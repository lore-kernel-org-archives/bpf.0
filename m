Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACF1EE7B7
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573521; cv=none; b=WMsL/Mx2DhHeJ8GiuHbHaXzROWIQAL9js2bfWWEeQjh/4TpZTuw8OdYuPIwxUUibW3R7RB7ufi0VP0u7WvR2m6QglSUusn99/5hBSiHfCEQEI2Qlsb0qzotBFRGcqCEv6JzpRLYRSgZ/nwRgH2hJgtdh4bmNxOj7MIoBY/RP3LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573521; c=relaxed/simple;
	bh=1ySXIpfODb2Zxp8tuTfO91JDZb1V2WRNrVFzraU8WmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HlR85V4+3p7Y21qjilxjC617T8VcAGealXvxghe5PsoDHlvLR3mH/7cLa7H02stZO4tN9Dd1UqP8Ck7WchrPDdtYcL2BX/2pQmD6UOZxa+MmqvzTr4t+G9pGoUiEksFeYiqQLZY+8md6MLuOvvfDG51ABHMSr3bdf4mC7/RMqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNyz9H2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNyz9H2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DA71F000E9;
	Sat, 27 Jun 2026 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573520;
	bh=lYMbdYwbIsPwmh58d+gOLc685pMvHc1BrZfp+7wKvRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NNyz9H2cDgUw9SDkYBp8fAmMKxvcHqd8bOOYM6qdDyW+7Uf3oFKTl8KkTRabmIYOr
	 kWebV3IOZnSy8ajj2Men4b9TFOW4f4ofm6V9Z8unA9HaoE5q6W0oQys0r7T8WqcetH
	 YTRl8FZhu+AkYguqBxePy7XEWROpxd5Z7o+O7XHqz+Blx939MVbtb1E6ftF9ns4TcD
	 acIZZTiGN3urCthmjWoEdvKcWg5ZMeSuH6jBThciazYrWM/7JtGo5psGGpXc9G9Y6P
	 SrROij2QeK6YOc+8gZhK6il8uj1INs4ei4DwjNeE/WU8XZjMGV6XbhXTwg/+nfL4tQ
	 GxknDPfWRQpHw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 04/12] bpf: Create insn_array map for bpf
 SDT probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <809bd2ae46a0505a1f8fdaeacb4e1db489bfa641.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <809bd2ae46a0505a1f8fdaeacb4e1db489bfa641.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:18:38 +0000
Message-Id: <20260627151839.F2DA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Size of struct bpf_insn_array_value changes, breaking UAPI backwar=
ds compatibility for BPF_MAP_TYPE_INSN_ARRAY map creation.
- [High] SDT probes in shared subprograms are dropped for all but the first=
 main program that absorbs the subprogram.
- [High] Incorrect instruction offset calculation for SDT probes located in=
 subprograms, leading to offset corruption and verifier rejection.
--

commit 4c79777e0549d710e07ecb99bf27d3c4bb18d256
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Create insn_array map for bpf SDT probe

Create one BPF_MAP_TYPE_INSN_ARRAY map per program from the parsed
SDT entries. Each map is tagged with BPF_F_INSN_ARRAY_SDT and
populated with the instruction offset, argument count, and per-argument
registers.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
[ ... ]
> @@ -7732,7 +7739,9 @@ struct bpf_insn_array_value {
>  	__u32 orig_off;
>  	__u32 xlated_off;
>  	__u32 jitted_off;
> -	__u32 :32;
> +	__u8  nargs;		/* argument count (0..5) */
> +	__u8  arg_reg[5];	/* BPF register for each argument */
> +	__u8  pad[2];
>  };

[Severity: High]
Does this struct size change break UAPI backwards compatibility?

Because insn_array_alloc_check() unconditionally enforces a strict size che=
ck:

kernel/bpf/bpf_insn_array.c:insn_array_alloc_check() {
    u32 value_size =3D sizeof(struct bpf_insn_array_value);
   =20
    if (attr->max_entries =3D=3D 0 || attr->key_size !=3D 4 ||
        attr->value_size !=3D value_size ||
        attr->map_flags & ~BPF_F_INSN_ARRAY_SDT)
        return -EINVAL;
}

Older userspace binaries calling bpf_map_create() with the old value_size
will be rejected with -EINVAL.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -6686,6 +6692,131 @@ static int create_jt_map(struct bpf_object *obj, =
struct bpf_program *prog, struc
>  	return err;
>  }
> =20
> +static int bpf_object__resolve_sdt_progs(struct bpf_object *obj)
> +{
> +	int i, j;
> +	struct bpf_light_subprog *sp;
> +
> +	for (i =3D 0; i < obj->sdt_entry_cnt; i++) {
> +		struct sdt_entry *e =3D &obj->sdt_entries[i];
> +		struct bpf_program *prog, *subprog;
> +
> +		prog =3D find_prog_by_sec_insn(obj, e->sec_idx, e->insn_idx);
[ ... ]
> +		/* resolve subprog probe in the main prog that absorbed the subprog */
> +		if (prog_is_subprog(obj, prog) && prog->absorbed_by !=3D -1) {
> +			subprog =3D prog;
> +			prog =3D &obj->programs[prog->absorbed_by];

[Severity: High]
Does this logic drop SDT probes in shared subprograms for all but the first
main program that absorbed it?

By resolving the shared SDT entry exclusively to the main program indicated
by prog->absorbed_by, any tracing tools relying on SDT probes in this
subprogram will silently miss executions when the subprogram is executed
through alternate main programs.

> +			for (j =3D 0; j < prog->subprog_cnt; j++) {
> +				sp =3D &prog->subprogs[j];
> +				if (sp->sec_insn_off =3D=3D subprog->sec_insn_off) {
> +					e->insn_idx =3D sp->sub_insn_off +
> +						       (e->insn_idx - sp->sec_insn_off);
> +					break;
> +				}
> +			}
[ ... ]
> +static int bpf_object__create_sdt_maps(struct bpf_object *obj)
> +{
[ ... ]
> +	/* create insn_array maps per program and populate entries */
> +	for (i =3D 0; i < obj->sdt_entry_cnt; i++) {
> +		__u32 key;
> +		struct sdt_entry *e =3D &obj->sdt_entries[i];
> +		__u32 sdt_cnt =3D prog_sdt[e->prog_idx].sdt_cnt;
> +
> +		if (!sdt_cnt)
> +			continue;
> +
> +		prog =3D &obj->programs[e->prog_idx];
[ ... ]
> +		key =3D prog_sdt[e->prog_idx].next_key++;
> +
> +		memset(&val, 0, sizeof(val));
> +		val.nargs =3D e->nargs;
> +		val.orig_off =3D e->insn_idx - prog->sec_insn_off;

[Severity: High]
Can this offset calculation lead to verifier rejection later?

Earlier in bpf_object__resolve_sdt_progs(), e->insn_idx is updated to a 0-b=
ased
local offset relative to the main program.

Here in bpf_object__create_sdt_maps(), subtracting prog->sec_insn_off again
from an already localized offset will cause an integer underflow or offset
corruption if the main program's section offset is greater than 0. This will
cause the verifier to reject the BPF object.

> +		memcpy(val.arg_reg, e->arg_reg, sizeof(val.arg_reg));
> +
> +		err =3D bpf_map_update_elem(prog->sdt_map_fd, &key, &val, 0);
> +		if (err)
> +			goto out_free;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D4
