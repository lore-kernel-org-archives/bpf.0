Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907693DDDBC;
	Mon, 31 Aug 2026 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169117; cv=none; b=UD3RvBpZ9y3gXl3BN9LFjL7qg6K2SXJjAmrhZs+vp1bvWvpysgDLt0EzCPYdnds6snk0lm0wEiYKXffsMuCFJHkX36dVcZD1sKu4fNjSaJJMx4nV960DCZnntLMi/L0I7UVUYERyuq676wX8yCR2yTP39I3AE/LQp7J1mPOs3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169117; c=relaxed/simple;
	bh=f428e6cE+waYrAMuV10pSAg3oqyczLbR+3hmIaaILuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jWwZ+HPQEELjKTjzr8WnpPuf9IIAVXyFG3R9nWC0CsrI/Ak9K4UvTANRhKlQJ9cEI1PpdLcPbqbdsczs2Z9e/Zj35xMnIoL6riwYLjZ3pONSmA/RVLf+9+mEw/BrFWdhj6ck4T6Js1Pd6j9FOy1wnmP4aQss3oPfhkjtjxJMVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhyIbRXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhyIbRXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0208C1F000E9;
	Mon, 31 Aug 2026 09:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169116;
	bh=0jgoRWLG0C4TuwfmKDEPcXzYxJZxcx3NV7Xv1jI4uLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NhyIbRXiONBNEyaKHbE3/r3V24vvY7PtS/mLzdTT/g43Gg5jOWc2i9Z+40xTw5fGy
	 GVsosvuZn6/DG1mdk3qTzdoT5MulQBDMU/R6b7ZyRJos/b8qj9/dOS+ZUoiyAkzsEg
	 8336DIwHbP1uVsjAtDWJz/KpTqRB8lHIHwx260DBI8232evw0GD3eqpqACHp6sMVeQ
	 EtsgGIwWnhMFc0Z6NlAnjE/IqTFV/tMZGnoakl8AFPKG1ChjsjWEXbC8qRVcFuwdJB
	 Ogyc5peHsYo/lrWqFJLHoNMfvWBCAR9HcemUzOtrcPlJR13vKMWBDmxpHDG/w1XPf4
	 QOO2BDoEG1NMw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/20] tools/rv: Implement BPF monitor registration
 logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260831090524.106845-15-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-15-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:38:35 +0000
Message-Id: <20260831093836.0208C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing directory creation for BPF_PIN_BASE_PATH causes immediate =
pinning failure on fresh systems.

Pre-existing issues:
- [High] A single failure when resetting map elements causes all subsequent=
 maps to be silently skipped.
--

commit 540f0c8b5ced934d1d1110f3772b2b0284013689
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Implement BPF monitor registration logic
   =20
Add support for registering and unregistering BPF monitors from
userspace via the struct_ops mechanism. The implementation scans known
paths for BPF monitor objects, loads them, and attaches their struct_ops
maps.

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification=
/rv/src/bpf_monitor.c
> index e13ae35678cb8..7e24a71dfac70 100644
> --- a/tools/verification/rv/src/bpf_monitor.c
> +++ b/tools/verification/rv/src/bpf_monitor.c
[ ... ]
> @@ -679,3 +680,340 @@ int bpf_run_monitor(char *monitor_name, int argc, c=
har **argv)
> =20
>  	return retval;
>  }
> +
> +/*
> + * register_monitor_from_file - register a single BPF monitor via struct=
_ops
> + *
> + * Opens, loads, and attaches a BPF monitor's struct_ops map, then pins =
the
> + * resulting link.
> + *
> + * Returns 0 on success, -1 on error
> + */
> +static int register_monitor_from_file(const char *path, const char *name)
> +{
[ ... ]
> +	link =3D bpf_map__attach_struct_ops(map);
> +	if (!link) {
> +		err_msg("bpf: error attaching struct_ops for %s: %s\n",
> +			name, strerror(errno));
> +		goto cleanup;
> +	}
> +
> +	snprintf(pin_path, sizeof(pin_path), "%s/%s", BPF_PIN_BASE_PATH, map_na=
me);
> +	res =3D bpf_link__pin(link, pin_path);

[Severity: High]
How does this code handle the case where the BPF_PIN_BASE_PATH directory
does not exist yet?

It appears that if the parent directory has not been manually created by the
user beforehand, bpf_link__pin() will return -ENOENT. This causes a
regression out-of-the-box on fresh systems where the registration tool
systematically fails.

Neither the kernel RV subsystem nor libbpf auto-creates this namespace
directory, which breaks the functionality of the tool for local
administrators.

[ ... ]

[Severity: High]
This is a pre-existing issue, but could the error handling in
reset_monitor_maps() inadvertently skip resetting subsequent maps on failur=
e?

tools/verification/rv/src/bpf_monitor.c:reset_monitor_maps() {
    ...
			while (!err && bpf_map_get_next_key(fd, NULL, key) =3D=3D 0)
				err |=3D bpf_map_delete_elem(fd, key);
    ...
			for (uint32_t idx =3D 0; !err && idx < max_entries; idx++)
				err |=3D bpf_map_update_elem(fd, &idx, zero_value, BPF_ANY);
    ...
}

If an error occurs while clearing a map (e.g., malloc failure for the key, =
or
bpf_map_update_elem failure), the err flag is set to true. The inner loops
for all subsequent maps strictly require !err in their conditions, meaning
they will be silently skipped without being reset.

This leaves stale state from previous runs in the maps, which could corrupt
the monitor's internal state machine when bpf_run_monitor() is called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D14
