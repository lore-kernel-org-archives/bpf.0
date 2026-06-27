Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696730D411
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782572805; cv=none; b=Th1F8N9gjrjduFP529y6TllZw5IlBlTMuyM/franDwswySsSDDTudCZwR4XhqfEaluoUs86S+Y0Ej7i+D2PjN7EwiRyhgPrkp6xjagEiX2ReBe3cz0YVKspnwz00TYqb0dTPjDtJy61FY8vxeykgrrFgW8hRbkhCFbMvY/UCiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782572805; c=relaxed/simple;
	bh=5Kxc1gnZ6hJbXVjPXnW6Bkv7N/uunIhMRJugSRtzJPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pnwGjC5nOcEi54xT3FpkQmnn8sf9AW/ZUhsLVta0Do6oAiCC4qkOJGG7dZ8G2E9Kd/zrzO5INcJ2ZL/6BxDx4Th7uucD4KQYIxwtROw7o4uFMlUwvbS94GLpQCR/hPziNPF/KoPCBsltcKKKyzBLQ1o+ECdAzHkgIZ33yYp/kL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE7L839J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE7L839J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2AD1F000E9;
	Sat, 27 Jun 2026 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782572802;
	bh=dMXpWBcljS4M5s4/IcmNxE0rhOHa/P6s+7R5G22/s9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kE7L839JRHQ2/DZw1mJepEH9B8u19PD6oteqqPLBvSJndR87zXsrGyki9uDzD+zGo
	 +OYCjdDPkbSpCSHJQOEqRFzqscX+0puME+MuWGtqOM9O1JSLEO05kaKXCJIqNzMgDi
	 zO1BgtZNX5vBhuPmj1WVQDwTypQ070I6qJIZosdZ5Ukb/0zHwyLaLXSrikQH3HdOWp
	 BQq/kCgeUadwz9i3a0EHBOVF5JsNSCVgIXz0SNwhx9ADdvzkkysWk4U4+HyLgO/Uo7
	 JlrNGgJgdvg1J82YY/UHOWxgTnhLm4rFr2Ttw5bEs1BPmKDFRKxh3XVqlClHhFfXgD
	 pFQuMqq+udr1g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 07/12] bpf: Record probe name in SDT map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <43eaa2bc686c9f8309d37b96f15646eaa9e51899.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <43eaa2bc686c9f8309d37b96f15646eaa9e51899.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:06:41 +0000
Message-Id: <20260627150641.BF2AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Strict `value_size` validation on the expanded `struct bpf_ins=
n_array_value` breaks backwards and forwards compatibility.
- [Medium] Memory leak of `e->name` on the error path in `bpf_object__colle=
ct_sdt_notes` when a probe name exceeds `BPF_SDT_MAX_NAME_LEN`.
--

commit 33292e7627dcc830a8b1dc17788ae56ec52849c6
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Record probe name in SDT map

This commit adds a probe name field to the bpf_insn_array_value structure to
help the kernel locate target programs and probe sites. It enforces a maxim=
um
name length of 64 characters and updates libbpf to pass the name during map
creation.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 773a7def0fbd3..95ca41bf75018 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
[ ... ]
> @@ -7743,6 +7744,7 @@ struct bpf_insn_array_value {
>  	__u8  nargs;		/* argument count (0..5) */
>  	__u8  arg_reg[5];	/* BPF register for each argument */
>  	__u8  pad[2];
> +	char  name[BPF_SDT_MAX_NAME_LEN]; /* probe name */
>  };

[Severity: Critical]
Does changing the size of struct bpf_insn_array_value break backwards
compatibility with older userspace applications?

It appears the kernel enforces a strict value_size check during map creation
in insn_array_alloc_check():

	if (attr->max_entries =3D=3D 0 || attr->key_size !=3D 4 ||
	    attr->value_size !=3D value_size ||
	    attr->map_flags & ~BPF_F_INSN_ARRAY_SDT)
		return -EINVAL;

Because value_size is derived from sizeof(struct bpf_insn_array_value),
older binaries passing a smaller value_size of 16 to
bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY) might now be rejected with -EINVAL.

[ ... ]
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index badac128e8adc..dbc08a1931015 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4146,6 +4146,12 @@ static int bpf_object__collect_sdt_notes(struct bp=
f_object *obj)
>  			err =3D -ENOMEM;
>  			goto out;
>  		}
> +		if (strlen(e->name) >=3D BPF_SDT_MAX_NAME_LEN) {
> +			pr_warn("sdt: probe name '%s' too long (max %d chars)\n",
> +				e->name, BPF_SDT_MAX_NAME_LEN - 1);
> +			err =3D -EINVAL;
> +			goto out;
> +		}

[Severity: Medium]
Can this goto leak the newly allocated e->name string?

Just above this snippet, e->name is allocated:

		e->name =3D strdup(sdt_syms[i].name + 10);
		if (!e->name) {
			err =3D -ENOMEM;
			goto out;
		}

If the length exceeds BPF_SDT_MAX_NAME_LEN, we jump to the out label.
However, the cleanup loop in out:

out:
	if (err) {
		for (i =3D 0; i < obj->sdt_entry_cnt; i++)
			free(obj->sdt_entries[i].name);

only frees up to obj->sdt_entry_cnt, which hasn't been incremented yet for
this entry, potentially causing the string to be leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D7
