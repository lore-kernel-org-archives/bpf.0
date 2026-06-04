Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F02846A;
	Thu,  4 Jun 2026 04:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545934; cv=none; b=PaXY8FcknSZq55hPjsfUiUUcEVCYz7yhHBOvIC8pZuveRqFNrJmK3zJtwEd3GnflGO8biKL87OvLuz94fU0HDdJjYbAL81mGWowLhZq1v01FiJdsNe0TYBTMwkLP1MKZscKfpLAS/N3L/5UUhPRJ1Y7Xs2+J6YHB2M31s1fRFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545934; c=relaxed/simple;
	bh=lNvsdxJ/BI5ORRFXANucIuUHierJNMGAVrblmlQSxSw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YWPkte2bXbnOn1l7MobsJjVyr1bU88Do9v9VUOLxpmR+AgcqpHzA1LF6ZDGQgPU8rPOXGDaiTF2SF9UmnhJ36QbsjUHy/Af/5CQvOIDwDdWVDH7O/eKmRd1di4uygbKVcX+WGBHRdbKB5aoCQZ8t0SK/fAZfk2grq5PmdHZpZms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEWP3mpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEWP3mpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E181F00893;
	Thu,  4 Jun 2026 04:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780545932;
	bh=IF5WyMIxTvA64kD8Fr6P2GPfVpCIARA718QJQsLiY5M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mEWP3mprOeDYrnbrcmFjiF1Z7Wths/D4G0MPE0EHaDHBKKsITUota04EKY9wUo52x
	 QNlBevuzs2S/GhYXKwHO2cqPh67D+lpDC58+yXrBUWtYOePMrVbMUXDfXTx1Sz/g43
	 OsivzpbgcsZglDtPOiONuT+IQ/jN2gHrVSWAX5N3yTNQ9idNAO5fq6mjxbXTmi5F2s
	 WYXP99YSIefuXkxyMQvSuRM2NygiqdqW8g17rx44vY8rT7ZTnHDZ2OXbXeyiBhD487
	 pD5apqoS2xBAvFflcFiG7MsXMglRYzESqhse6IbbgWoDRb2ktm7WEeD8deHXeEQSC6
	 EP3Ngekq+Ydzw==
Content-Type: multipart/mixed; boundary="===============3953869875251286636=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aec1ec55df3c4768bf8f33930e53a3349d519b824342fc8828bc7e300350b645@mail.kernel.org>
In-Reply-To: <20260604031033.806727-4-chenyuan_fl@163.com>
References: <20260604031033.806727-4-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v2 3/3] libbpf: fix feature probe failures for implicit BPF tokens
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,chenyuan_fl@163.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,daniel@iogearbox.net,eddyz87@gmail.com,linux-kselftest@vger.kernel.org,shuah@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 04:05:32 +0000 (UTC)

--===============3953869875251286636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..f934452e52f0 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -16,7 +16,14 @@ int probe_fd(int fd)
>  {
>  	if (fd >= 0)
>  		close(fd);
> -	return fd >= 0;
> +	/* Return 1 on success, negative error on failure, so
> +	 * feat_supported() can distinguish probe errors from
> +	 * genuine feature absence.  When a BPF token is present,
> +	 * a negative return triggers the rescue path that marks
> +	 * the feature as SUPPORTED (token creation itself proves
> +	 * the kernel BPF subsystem works).
> +	 */
> +	return fd >= 0 ? 1 : fd;
>  }

Does this return a literal -1 instead of the actual error code? Several
feature probes use internal direct syscall wrappers like sys_bpf_prog_load()
which return -1 on failure and leave the real error in errno. Since probe_fd()
returns this -1 unmodified instead of -errno, feat_supported() will pass -1 to
errstr():

tools/lib/bpf/features.c:feat_supported() {
    ...
    pr_warn("Detection of kernel %s support failed: %s\n",
            feat->desc, errstr(ret));
    ...
}

Because -1 equals -EPERM, does this cause the error string to unconditionally
resolve to "Operation not permitted" and mask the true reason for the probe
failure (like -EINVAL)?

https://lore.kernel.org/bpf/20260604032734.CE0D01F00893@smtp.kernel.org/

>
>  static int probe_kern_prog_name(int token_fd)

[ ... ]

> @@ -725,9 +732,21 @@ bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_
>  		} else if (ret == 0) {
>  			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>  		} else {
> +			/*
> +			 * A BPF token may restrict which program/map types
> +			 * are permitted, causing the probe to fail even
> +			 * though the kernel supports the feature.  When a
> +			 * token is present the probe is best-effort: BPF
> +			 * token creation itself proves the kernel has a
> +			 * working BPF subsystem.  Real BPF issues will be
> +			 * caught during actual program/map loading.
> +			 */
> +			if (cache->token_fd)
> +				WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
> +			else
> +				WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);

Will this forcefully override genuine missing features to FEAT_SUPPORTED if a
token is present?

By returning < 0 from probe_fd(), genuine feature absences now fall into this
error-handling path. If a newer BPF feature is missing on an older kernel that
supports tokens, libbpf might incorrectly mark it as supported and skip
essential sanitizations (like stripping unsupported BTF tags).

Does this bypass the fallback logic and cause the final program load to fatally
fail?

https://lore.kernel.org/bpf/20260604032734.CE0D01F00893@smtp.kernel.org/

>  			pr_warn("Detection of kernel %s support failed: %s\n",
>  				feat->desc, errstr(ret));
> -			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>  		}
>  	}

Are there existing probes that still return 0 on failure and bypass this rescue
mechanism?

For instance, probe_prog_bind_map() returns 0 if bpf_prog_load() fails:

tools/lib/bpf/features.c:probe_prog_bind_map() {
    ...
    if (prog < 0) {
        close(map);
        return 0;
    }
    ...
}

Since these functions were not updated to propagate negative error codes, they
evaluate via the else if (ret == 0) branch and are immediately marked as
FEAT_MISSING.

Does this leave unprivileged BPF token support broken for these specific
features?

https://lore.kernel.org/bpf/20260604032734.CE0D01F00893@smtp.kernel.org/

Without curly braces around the else block, the pr_warn() call executes
unconditionally for any negative return value. Combined with probe_fd() now
returning < 0 for all missing features, will this loudly spam warnings to the
console for normal feature absence checks?

https://lore.kernel.org/bpf/20260604032734.CE0D01F00893@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26928747574
--===============3953869875251286636==--
