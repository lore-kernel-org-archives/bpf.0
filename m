Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88352B1D2;
	Thu,  1 Oct 2026 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869231; cv=none; b=E+W30t8Nj/oy1TQf5wRL1Es1s/Sn5cawVbspUXkbUe+0zNMj4L6HFgxwmY0sq2txqzHEVyv+Bt2YESEH8M4w/i8F3uZdPqm+qakVgbXam2sFZ4nU8Lx5qv4PCYHqnNIZoux5rSKn/lKWKNUjfBRC5dddupV+PV0HAe/vc5ly8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869231; c=relaxed/simple;
	bh=wrdEMkqOKVODN+lCD8iZuLd9HUREZaVL67sHGn77WyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNuyq/dm4k8UtZ87qWBeng4cD/Z9lvp0OvOR30N5XDK0Qlt+TIkN583v4Xwp0f1VsocWhP41uqIA45oPKH3LfxnXTm4qJpzGVJrZQkAmrtgpbJ0dZ3sGLWZZD21EJle+9oc/wPdjvyalBNMUEnTAdkZ1hCTFfVVS9R3Hkqsk59Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl51gdLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl51gdLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1401F000FF;
	Thu,  1 Oct 2026 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869229;
	bh=ZjukmqZBr/Q8r3D4WjCPnBjlNxnvVv1+ak3oNNvpPfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gl51gdLxX+CJCy0nd3WTSOiCWHJQotoOWJaT2WDvfsLFW2LIClV09nxd80Eow5+k7
	 EZTA1DmpfaEfjWtiYe0G5oU7ziYVAwaUoL9vl6rmVgGj463MfpA4OxY92+JUzFUgH8
	 ylryT9roO9z2vc9QQDj/W2tuN/Y5+zUWw5Xops46hw5dj+CvSV95x1TfVSj/DzlvST
	 ojGYW5WLVxqtK1OiPjm7Qnol6mLnKyTv9/jDO/wj2dZH4zpj/NheCR4LoVMJAVRlUj
	 um2Fb38D7+NcXWE713JT/zudBXWIOn8JQvxKa7yi53Z8p6bWZYsFTnYJmHB3/FeC2q
	 taxKTh2Rtke4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] tools/rv: Implement BPF monitor discovery and
 listing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261001152042.124445-8-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-8-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:40:28 +0000
Message-Id: <20261001154029.5E1401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: stack OOB access via unterminated strncpy()
- [Low] bpf: off-by-one snprintf check and file leak
--

commit 87f9013a78d7a34904987bd2e9122ad081e635b2
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Implement BPF monitor discovery and listing

Implement the BPF monitor listing functionality that scans for compiled
BPF monitor object files and displays them in the monitor list.

> diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification=
/rv/src/bpf_monitor.c
> new file mode 100644
> index 0000000000000..a1de0c1577128
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
> +		size =3D snprintf(obj_path, sizeof(obj_path), "%s/%s", path,
> +				entry->d_name);
> +		obj =3D bpf_object__open_file(obj_path, NULL);
> +		if (!obj || size > MAX_PATH) {

[Severity: Low]
Does this logic correctly handle path truncation?

The check size > MAX_PATH has an off-by-one error since snprintf() returns =
the
number of characters that would have been written excluding the null byte,
meaning truncation occurs if size >=3D MAX_PATH (or sizeof(obj_path)).

Also, bpf_object__open_file() is called before this check, potentially
operating on truncated paths. If open_file succeeds on a truncated string,
would the obj resource be leaked on the error path via the continue stateme=
nt?

> +			err_msg("bpf: error opening object file %s: %s\n",
> +				obj_path, strerror(errno));
> +			continue;
> +		}
> +
> +		strncpy(name, entry->d_name, sizeof(name));
> +		ext =3D strrchr(name, '.');
> +		if (ext)
> +			*ext =3D '\0';

[Severity: Medium]
Could this sequence result in a stack out-of-bounds read and write?

If entry->d_name is exactly MAX_DA_NAME_LEN characters or longer, strncpy()
will leave the name array without a null terminator.

This causes strrchr() to scan adjacent stack memory (such as obj_path) to
find a '.', and potentially write a '\0' out of bounds if one is found. Can
this be triggered by a local user placing a file with a long name in the
bpf_monitors directory?

> +
> +		action(name, obj);
> +
> +		bpf_object__close(obj);
> +	}
> +
> +	closedir(dir);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001152042.1244=
45-1-gmonaco@redhat.com?part=3D7
