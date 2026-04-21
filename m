Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D41DE2D3
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776735803; cv=none; b=JE8sibvU8PmXjiP4Mz3PCQtJntri2sVvPO2oruQerzgjwcRg39xBOBxk7l7+sBHX7fdJ7NRrgFgza1tVE1llNk5obRnsrLujbBYuntg02wm4uvMUhdS+nUzKqdXoH+/H/IVvsmq3VI1491p8bFGBl5hZ1D/1xsuK1xUZ7rPT3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776735803; c=relaxed/simple;
	bh=NWOkxFqyvZLsVlErADLEiO6dc/tDD4uYL1YZL5+MJzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjMzdyqKvXJ24aGcsu7bgG3jFgasMu1ugWQU84u2tmfbKXD/8Bt/Wp/da9vcqwEOoql0L71ocyCYbIifK3+mxgLS6DnagvfKAL16lICuH6adODDrzeDmpf2VrBdPDMU+DLfkfgyhYyE7dENqekRvWPS7IEZZyUiDaslR3rm5q6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L6FU5bCm; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L6FU5bCm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776735798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lY14lVBHSnRMPsI9xJM2Z3mLDjqRIlaznhAuVqy2N74=;
	b=L6FU5bCm8gdfmgxJJkq8iQx2fKYKqjZt9fT0ns2rYNRQ1W5Vg008jDCA/cZegDGP9rxwmr
	JxAsea8vH7u+PWUOVmLP3H1lCJdihuSG/wNMTgcu1acuUGbuC37vn5o/9H85CzCwUfUh3N
	LylcJrh6NOLwksoJhwYc/jjeq3FImTw=
From: Leon Hwang <leon.hwang@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>,
	bot+bpf-ci@kernel.org,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Eduard <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	kernel-patches-bot@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Chris Mason <clm@meta.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
Date: Tue, 21 Apr 2026 09:42:43 +0800
Message-ID: <20260421014255.210566-1-leon.hwang@linux.dev>
In-Reply-To: <DHY2JXM90466.13PVYC6ITVFKS@gmail.com>
References: <20260414132421.63409-3-leon.hwang@linux.dev>  <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>  <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>  <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>  <3556a456-70d3-45e7-affa-355107bac30e@linux.dev>  <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>  <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com>  <20260420052459.85772-1-leon.hwang@linux.dev>  <DHY2JXM90466.13PVYC6ITVFKS@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, 20 Apr 2026 07:58:06 -0700, "Alexei Starovoitov" <alexei.starovoito=
v@gmail.com> wrote:=0D
> On Sun Apr 19, 2026 at 10:24 PM PDT, Leon Hwang wrote:=0D
>>=0D
>> int xdp_prog(struct xdp_md * ctx):=0D
>> ; cnt++;=0D
>> 0: (18) r6 =3D map[id:28][0]+0=0D
>> 2: (bf) r6 =3D &(void __percpu *)(r6)=0D
>=0D
> well. that insn was inserted by the verifier and it shows up in xlated.=0D
> That was expected.=0D
> The point about 'bogus xlated' was about offset translation.=0D
> map_direct_value_meta() should recover proper insns[i + 1].imm =3D off;=0D
> In your example it's zero, so not an interesting test.=0D
>=0D
=0D
The original insns[i + 1] wasn't broken. See the key change of this=0D
patch.=0D
=0D
+			/*=0D
+			 * Reuse the original ld_imm64 insn, and add one=0D
+			 * mov64_percpu_reg insn.=0D
+			 */=0D
+=0D
+			insn_buf[0] =3D insn[1];=0D
+			insn_buf[1] =3D BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);=0D
+			cnt =3D 2;=0D
+=0D
+			i++;=0D
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);=0D
+			if (!new_prog)=0D
+				return -ENOMEM;=0D
=0D
So, it didn't touch the original ld_imm64 insn. That said, no bogus=0D
xlated about offset translation.=0D
=0D
>=0D
[...]=0D
>> @@ -6370,7 +6372,8 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn=0D
>> if (tnum_is_const(reg->var_off) &&=0D
>> bpf_map_is_rdonly(map) &&=0D
>> map->ops->map_direct_value_addr &&=0D
>> -                           map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) =
{=0D
>> +                           map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY &=
&=0D
>> +                           map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY=
) {=0D
>=0D
> why add BPF_MAP_TYPE_PERCPU_ARRAY here?=0D
>=0D
=0D
After looking into bpf_map_is_rdonly(), yes, no need to add check for=0D
percpu_array here.=0D
=0D
Thanks,=0D
Leon=0D
=0D
>> int map_off =3D off + reg->var_off.value;=0D
>> u64 val =3D 0;=0D
