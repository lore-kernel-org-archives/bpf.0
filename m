Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1A387369;
	Sun, 23 Aug 2026 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787497837; cv=none; b=embyCrDml/SBjsUdXnhlvywteqC5zSWqJiZ4VB+rXVuS1uFZs6AH496qs0R+YYdJNIzwiDEc8Hy2/SdtEtgDSJi6BrbB4/Qy8wqpGiPK0SyMFkDGR0dsUBckaWyPks0JDEZxlZ3ZIYUIg+jDtBSp1xgWDQuP46/V6eGpDo4uc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787497837; c=relaxed/simple;
	bh=AhMXWEi8psArpOaGOX5krq8cgB+8nBKMx4gK/ssaVBc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uKiIo68VCVUjo4Zy+0EeX2+Vdj3IRmdZqgjMRSuFFTfkiF2+avY3JIohP338LdHoA6pnG7hnA0ws3C07+yHV3uO82TjtEyy7JT+R4+YWKpuNUaQFFIGQy8WR6N/jc5DlBD4DIJm7FGYq5GicoaeXN1APOgbFrcOvjBzYnmliEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXXC6cPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXXC6cPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C5F1F00A3A;
	Sun, 23 Aug 2026 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787497835;
	bh=BuxCXIr7Z0qKtVvgRTP+cOFNVj77RsekdEZ25izm0R0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BXXC6cPJt0eFc2XyTbG2Yh4C6YcWkyqZPYTVTzAWShRwR2hxXlUyFHBy+TUonzvMP
	 7ZdUtMWpg3jAYRAXn4PY1iYqwl6guEQG7amDaLL+SZucGiTTIfsN9iNf74UprLpg5T
	 7fjZEulZbyqeq7qhgEZsjKyh0n0VK1JVk1urwFpGmAJE3HXz4p18kUf4OLey3Pgrio
	 FxSj5nS7DZ1dpKasGBX4IvdmMgC8W7B2HHUFMSP8F/TP3yz0wuBgr3c/oYG5f1tiu3
	 towIVhTuE+4UrPR8uk78bnCWBpoU6AgEHzk583nVMBgsjUqCCTVu77orsCdwXBKUP3
	 0FLSyhk0J7YIQ==
Content-Type: multipart/mixed; boundary="===============9084743837741285848=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c28eaf23d832d13fd2ef828e8ae57d4b0c833dad5ce1ab13209f444e387a5ae7@mail.kernel.org>
In-Reply-To: <74387ae5024d7e2996095e97211430285095b525.1787492521.git.shijianlin11@foxmail.com>
References: <74387ae5024d7e2996095e97211430285095b525.1787492521.git.shijianlin11@foxmail.com>
Subject: Re: [PATCH bpf-next v4 4/5] bpf: reject oversized bpf_stream_vprintk output with -E2BIG
From: bot+bpf-ci@kernel.org
To: shijianlin11@foxmail.com,bpf@vger.kernel.org,memxor@gmail.com
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@chromium.org,sdf@falco.dk,haoluo@google.com,jolsa@kernel.org,emil@tsalapatis.com,pulehui@huawei.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 15:10:35 +0000 (UTC)

--===============9084743837741285848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 09471a605268..7a5c3ac8676b 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c

[ ... ]

> @@ -245,6 +245,11 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const vo
>  		return ret;
>
>  	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
> +	/* Truncation: reject before capacity charge (not -ENOMEM). */
> +	if (ret >= MAX_BPRINTF_BUF) {
> +		bpf_bprintf_cleanup(&data);
> +		return -E2BIG;
> +	}
>  	/* Exclude NULL byte during push. */
>  	ret = bpf_stream_push_str(stream, data.buf, ret);
>  	bpf_bprintf_cleanup(&data);

This isn't a bug, but could the truncation case set ret = -E2BIG and
fall through to the existing bpf_bprintf_cleanup(), so the buffer release
stays in one place?

The single-cleanup pattern appears elsewhere in this area:
bpf_stream_stage_printk() has one bpf_put_buffers() at the end, and
bpf_bprintf_prepare() funnels every failure through 'goto out'.

Something like:

	if (ret >= MAX_BPRINTF_BUF)
		ret = -E2BIG;
	else
		ret = bpf_stream_push_str(stream, data.buf, ret);
	bpf_bprintf_cleanup(&data);
	return ret;

would keep the release in one place.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32645868670
--===============9084743837741285848==--
