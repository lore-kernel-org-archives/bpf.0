Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699080;
	b=EqJ3gRrqgctn+IfB8JpwAjRekWJ591xHeO1xYUmtJJA07CmRh0o0Da4uqa6T9RaTm6B2
	 F9yvIS+j2Ct9gDWgh8CHrRc5p/MBrFMjRumdbsA/k/JDLvmVDWuAuybPujkb9Dx0dUmOq
	 Z18XSGY4ZxcPS0pjyd4ZJqrlSnxVm5iKDAP8NQB+6v/gSs3r/G6bpU5AUu4IRRtEEp4aS
	 pSBQmCfEzRnPnXIBA3aCTgVXC6nkmIh9dQBtjRsk36NZVYI0oFGETakY+gcWg78BSMDZO
	 udAEb0VDc4H/XL6AJ8S7Ivlkq3ZIQc2XrGCK4ybM9pMQgr8/xL9dMo9WkJsZ6VcsE3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699080;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tJIT2YygOW/UrqJ3/nF/k6iSZa8thmnGzz59Z0urV10=;
	b=XNU9bwR9asy8ngHqJwRk2SDhD1Htt7dmRX8Ip7/CQRoKDvhGpKMOOq5wtL1SthXvE60J
	 FngR9JJd3eSQO7E26iRjK4uadLObsvhRqBzombWby3DIugwwFWhDBN319hmHv2AcT2z4m
	 ADF87pgsRdsrUvyaQxM9e8zxm3E5bjlOKe/HRl1xspAjft8PsCerxZ3zoSko1msPQ9XBu
	 Nh63BPM1I5TnGHgOVoVCrklyBPRzvmyVqnDIzBmVD3qeluomvnIjsugnpo3bkLq+nmLgh
	 hUuCNmz+r0qOHv1x3ZHcU9Sysc6I7FuVL2pbxYE6WyMVsUPklYuBUsY+RtT2KA0J0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUNtvDgI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05D606A329;
	Thu, 26 Nov 2026 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUNtvDgI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5351C1F000D3;
	Thu, 26 Nov 2026 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699080;
	bh=tJIT2YygOW/UrqJ3/nF/k6iSZa8thmnGzz59Z0urV10=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LUNtvDgI2C50yOedZgTVzMs+GardN1SOnO/6BHYW1ih4zwMpPrhm405xjNhfPJC9W
	 B0+b+oYu+z3pjCmTJMxDAQx/2k/yxRYIz5+QQvtlF16Z8uSUlx6P+qA9MDJuxjEvOF
	 AJj/zAyQQH2J5uZYpJe4CPU66O0aMwo0fQ/lEDg2uaHn2K8n/zbx5dtLjpTx11s3r3
	 By3D9v5biILDWif80oHgXWhBuBGqUOKPpWZ/iTYfPV/Eqfjjbglh7+YqukBGktUOms
	 gQRDSO8x0xfaVKrkpgtDuccQB0W6tWS19PKxy5a7wkUvYlYmR5gfDZCKVY4Zg57I6h
	 G028jbOSfGRTQ==
Message-ID: <sashiko-outbox-235588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/18] tools/rv: Implement BPF monitor discovery and
 listing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126130004.127155-10-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
 <20261126130004.127155-10-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:17:59 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] tools/rv: path truncation checked after open in
  bpf_object_iterate_path()
- [Low] tools/rv: uncoordinated monitor listing in rv_list() and
  ikm_list_monitors()
--

commit 4abb124d92aede7d5ee4cdd253273b42ad6b0fdc
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Implement BPF monitor discovery and listing

This commit adds libbpf detection to the rv build configuration and
implements discovery and listing of compiled BPF monitor object files
for rv list.

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification=
/rv/src/bpf_monitor.c
> new file mode 100644
> index 0000000000000..a5767617c7200
> --- /dev/null
> +++ b/tools/verification/rv/src/bpf_monitor.c

[ ... ]

> +static void bpf_object_iterate_path(const char *base_path, const char *s=
ubdir,
> +				    void (*action)(const char *name, struct bpf_object *obj))
> +{
> +	char path[MAX_PATH];
> +	struct dirent *entry;
> +	DIR *dir;
> +	char *ext;
> +
> +	snprintf(path, sizeof(path), "%s/%s", base_path, subdir);
> +	dir =3D opendir(path);
> +	if (!dir) {
> +		debug_msg("bpf: error opening directory: %s\n", path);
> +		return;
> +	}
> +
> +	while ((entry =3D readdir(dir)) !=3D NULL) {
> +		size_t size;
> +		struct bpf_object *obj;
> +		char name[MAX_DA_NAME_LEN], obj_path[MAX_PATH];
> +
> +		if (entry->d_name[0] =3D=3D '.')
> +			continue;
> +
> +		ext =3D strrchr(entry->d_name, '.');
> +		if (!ext || strcmp(ext, ".o") !=3D 0)
> +			continue;
> +
> +		size =3D (size_t)(ext - entry->d_name);
> +		if (size >=3D MAX_DA_NAME_LEN) {
> +			err_msg("bpf: name too long, skipping %s/%s\n", path,
> +				entry->d_name);
> +			continue;
> +		}
> +		memcpy(name, entry->d_name, size);
> +		name[size] =3D '\0';
> +
> +		size =3D snprintf(obj_path, sizeof(obj_path), "%s/%s", path,
> +				entry->d_name);
> +		obj =3D bpf_object__open_file(obj_path, NULL);
> +		if (!obj || size >=3D MAX_PATH) {
> +			err_msg("bpf: error opening object file %s: %s\n",
> +				obj_path, strerror(errno));
> +			continue;
> +		}

[Severity: Low]
Should size >=3D MAX_PATH be checked before calling bpf_object__open_file()?

When the formatted path reaches MAX_PATH, bpf_object__open_file() is
invoked on a truncated obj_path.  If opening the truncated path succeeds,
the size >=3D MAX_PATH branch logs a stale errno and continues without
calling bpf_object__close(obj), leaking obj.  Also, the earlier
snprintf(path, sizeof(path), "%s/%s", base_path, subdir) does not check
for truncation when formatting base_path (which is itself sized MAX_PATH).

[ ... ]

> diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/r=
v.c
> index 09e0d85986196..7c4a2e49ff9d1 100644
> --- a/tools/verification/rv/src/rv.c
> +++ b/tools/verification/rv/src/rv.c
> @@ -13,6 +13,7 @@
>  #include <trace.h>
>  #include <utils.h>
>  #include <in_kernel.h>
> +#include <bpf_monitor.h>
> =20
>  static int stop_session;
> =20
> @@ -76,6 +77,7 @@ static void rv_list(int argc, char **argv)
>  	}
> =20
>  	ikm_list_monitors(container);
> +	bpf_list_monitors(container);
> =20
>  	exit(EXIT_SUCCESS);
>  }

[Severity: Low]
Does calling ikm_list_monitors() and bpf_list_monitors() independently
produce broken output when no in-kernel monitors are registered or listed?

tools/verification/rv/src/in_kernel.c:ikm_list_monitors() {
	available_monitors =3D tracefs_instance_file_read(NULL, "rv/available_moni=
tors", NULL);

	if (!available_monitors) {
		err_msg("ikm: available monitors is not available, is CONFIG_RV enabled?\=
n");
		return -1;
	}

	curr =3D available_monitors;
	do {
		next =3D strstr(curr, "\n");
		*next =3D '\0';

		retval =3D ikm_fill_monitor_definition(curr, &ikm, container);
		if (retval < 0)
			err_msg("ikm: error reading %d in kernel monitor, skipping\n", curr);
    ...
	if (!list_monitor) {
		if (container)
			printf("-- No monitor found in container %s --\n", container);
		else
			printf("-- No monitor found --\n");
	}
}

When CONFIG_RV is enabled without any in-kernel CONFIG_RV_MON_* monitors,
rv/available_monitors is 0 bytes and tracefs_instance_file_read() returns
NULL, so ikm_list_monitors() prints the error asking if CONFIG_RV is
enabled before bpf_list_monitors() lists the BPF monitors (and if an empty
string were returned, strstr(curr, "\n") would return NULL and *next =3D '\=
0'
would dereference NULL).  Even when in-kernel monitors exist, if none are
printed, ikm_list_monitors() prints "-- No monitor found --" right before
bpf_list_monitors() prints the available BPF monitors.  In addition, the
error message in ikm_list_monitors() formats curr (char *) with %d instead
of %s.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126130004.1271=
55-1-gmonaco@redhat.com?part=3D9
