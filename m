Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EC214204
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662714; cv=none; b=RaQaumsCPYyHiwX3opmxrhM/AJI+PFMihnrLhstd1f4Uk8swIJ1wBINIIXGTswVVRXCRY4Z98r1Sqgloqyc+yGxY5rvJ68STTNkkU2C+kGWMBE9CXz47QIihimJ5VZkkVIgX8Xd8+7/eji4rhJjmRaH15WxCP7rFRRf2GH1++bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662714; c=relaxed/simple;
	bh=EvLQJ6R8B1qTSwBv8E5qLy9Awtq/5hJKu2omAZGq134=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ9fceVou9VwqKI9dbIKvhmf1S796jCWqMm6smUAwyjEIdH7JeCN1pqtZ0Lybou91zGYcEqob7YrjeBU3P6HVEvFGeqTQJvZInwGWSmjnsG17Tpq6OGQmCdzpGFfuAtB+fDRNvQYLKnb8Ycae963K9fIr4WR8uXWM2P/uR5fGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mZjPfKs7; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mZjPfKs7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776662709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLVLhq1gpfTbnCdO3T9ESFX8xqODGkYMKr53bt/Iuww=;
	b=mZjPfKs7sFYgHHVe3RmCYO7S9yVbHY3NdN2Ibo/mj4fuyfbR41XYrwHqm8hu24O8+hupzK
	akOsx52QQnb/HuLsCfG21KjL3liWX5k+4T1BRu3db64kFJL9XdsRIHwXHNDzN980oQuybc
	dvhNbQWhNtsAuvL6/pjfxL1cZdpEyvU=
From: Leon Hwang <leon.hwang@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Date: Mon, 20 Apr 2026 13:24:57 +0800
Message-ID: <20260420052459.85772-1-leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com>
References: <20260414132421.63409-3-leon.hwang@linux.dev>  <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>  <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>  <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>  <3556a456-70d3-45e7-affa-355107bac30e@linux.dev>  <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>  <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri, 17 Apr 2026 10:03:19 -0700, Alexei Starovoitov <alexei.starovoitov@=
gmail.com> wrote:=0D
> On Fri, Apr 17, 2026 at 8:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev>=
 wrote:=0D
>>=0D
>> On 2026/4/17 09:30, Leon Hwang wrote:=0D
>>> On 15/4/26 10:19, Alexei Starovoitov wrote:=0D
>>>> On Tue, Apr 14, 2026 at 10:19:22PM +0800, Leon Hwang wrote:=0D
>>>>> On 2026/4/14 22:10, bot+bpf-ci@kernel.org wrote:=0D
>>> [...]=0D
>>>>>> In the v3 series, bpf_map_direct_read() itself had a guard=0D
>>>>>> (map->map_type !=3D BPF_MAP_TYPE_ARRAY), which protected all callers=
.=0D
>>>>>> The v4 moved this to caller-side checks but appears to have missed=0D
>>>>>> const_reg_xfer().=0D
>>>>>>=0D
>>>>>>=0D
>>>>> Correct.=0D
>>>>>=0D
>>>>> Will add a guard in bpf_map_direct_read() in the next revision:=0D
>>>>>=0D
>>>>>     if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)=0D
>>>>>             return -EINVAL;=0D
>>>>=0D
>>>> hold on.=0D
>>>>                          map->ops->map_direct_value_addr &&=0D
>>>> -                        map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {=
=0D
>>>> +                        map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY &&=
=0D
>>>> +                        map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)=
 {=0D
>>>>=0D
>>>> map_direct_value_addr() is set, but then immediately disallowed ?=0D
>>>> Where else it's used?=0D
>>>>=0D
>>>> Even if value_addr is working, then map_direct_value_meta() looks brok=
en.=0D
>>>>=0D
>>=0D
>> IIUC, map_direct_value_meta() is only used for dumping xlated insns. If=
=0D
>> no available map_direct_value_addr(), map_direct_value_meta() won't be=0D
>> called.=0D
>=0D
> yes, but then xlated insn are bogus, no?=0D
>=0D
=0D
No. They look well.=0D
=0D
./test_progs -t global_percpu_data -v=0D
=0D
XLATED:=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
0: r1 =3D 0x900000007=0D
2: r1 =3D &(void __percpu *)(r1)=0D
3: r1 =3D *(u8 *)(r1 +0)=0D
4: w0 =3D 1=0D
5: if w1 =3D=3D 0x64 goto pc+1=0D
6: w0 =3D 0=0D
7: exit=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
#152/5   global_percpu_data/verifier_percpu_read:OK=0D
=0D
I also verified the xlated insns via bpftool.=0D
=0D
static SEC(".data") __u32 cnt =3D 0; /* .data vs .percpu */=0D
=0D
SEC("xdp")=0D
int xdp_prog(struct xdp_md *ctx)=0D
{=0D
    cnt++;=0D
=0D
    __u32 cpu =3D bpf_get_smp_processor_id();=0D
    bpf_printk("cpu: %u, cnt: %u\n", cpu, cnt);=0D
=0D
    return XDP_PASS;=0D
}=0D
=0D
When the section of cnt is ".data", bpftool d x n xdp_prog:=0D
=0D
int xdp_prog(struct xdp_md * ctx):=0D
; cnt++;=0D
   0: (18) r6 =3D map[id:23][0]+0=0D
   2: (61) r1 =3D *(u32 *)(r6 +0)=0D
; cnt++;=0D
   3: (07) r1 +=3D 1=0D
; cnt++;=0D
   4: (63) *(u32 *)(r6 +0) =3D r1=0D
; __u32 cpu =3D bpf_get_smp_processor_id();=0D
   5: (b7) r0 =3D -1280774092=0D
   6: (bf) r0 =3D &(void __percpu *)(r0)=0D
   7: (61) r0 =3D *(u32 *)(r0 +0)=0D
; bpf_printk("cpu: %u, cnt: %u\n", cpu, cnt);=0D
   8: (61) r4 =3D *(u32 *)(r6 +0)=0D
   9: (18) r1 =3D map[id:24][0]+0=0D
  11: (b7) r2 =3D 18=0D
  12: (bf) r3 =3D r0=0D
  13: (85) call bpf_trace_printk#-129408=0D
; return XDP_PASS;=0D
  14: (b7) r0 =3D 2=0D
  15: (95) exit=0D
=0D
When the section of cnt is ".percpu", bpftool d x n xdp_prog:=0D
=0D
int xdp_prog(struct xdp_md * ctx):=0D
; cnt++;=0D
   0: (18) r6 =3D map[id:28][0]+0=0D
   2: (bf) r6 =3D &(void __percpu *)(r6)=0D
   3: (61) r1 =3D *(u32 *)(r6 +0)=0D
; cnt++;=0D
   4: (07) r1 +=3D 1=0D
; cnt++;=0D
   5: (63) *(u32 *)(r6 +0) =3D r1=0D
; __u32 cpu =3D bpf_get_smp_processor_id();=0D
   6: (b7) r0 =3D -1280774092=0D
   7: (bf) r0 =3D &(void __percpu *)(r0)=0D
   8: (61) r0 =3D *(u32 *)(r0 +0)=0D
; bpf_printk("cpu: %u, cnt: %u\n", cpu, cnt);=0D
   9: (61) r4 =3D *(u32 *)(r6 +0)=0D
  10: (18) r1 =3D map[id:30][0]+0=0D
  12: (b7) r2 =3D 18=0D
  13: (bf) r3 =3D r0=0D
  14: (85) call bpf_trace_printk#-129408=0D
; return XDP_PASS;=0D
  15: (b7) r0 =3D 2=0D
  16: (95) exit=0D
=0D
The difference between these xlated insns is "r6 =3D &(void __percpu *)(r6)=
".=0D
This insn is for ".percpu", not for ".data".=0D
=0D
>>>=0D
>>> Ah, let me dive deeper.=0D
>>>=0D
>>=0D
>> As for the above changes, let me explain them using diff snippet.=0D
>>=0D
>> @@ -5808,6 +5808,8 @@ int bpf_map_direct_read(struct bpf_map *map, int=0D
>> off, int size, u64 *val,=0D
>>         u64 addr;=0D
>>         int err;=0D
>>=0D
>> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)=0D
>> +               return -EINVAL;=0D
>>         err =3D map->ops->map_direct_value_addr(map, &addr, off);=0D
>>         if (err)=0D
>>                 return err;=0D
>>=0D
>> It is to guard percpu_array map against const_reg_xfer(). Instead of=0D
>> updating const_reg_xfer(), better to update bpf_map_direct_read(). WDYT?=
=0D
>=0D
> yeah and move map_type !=3D BPF_MAP_TYPE_INSN_ARRAY check=0D
> into bpf_map_direct_read() as well.=0D
> To cleanup const_reg_xfer() a bit.=0D
=0D
Before sending the next revision, just confirm the change:=0D
=0D
1. Move "map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY" from const_reg_xfer(=
)=0D
   to bpf_map_direct_read().=0D
2. Keep "map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY" in=0D
   check_mem_access(), because we should not propagate the error from=0D
   bpf_map_direct_read() for insn_array and percpu_array.=0D
=0D
Thanks,=0D
Leon=0D
=0D
---=0D
=0D
--- a/kernel/bpf/const_fold.c=0D
+++ b/kernel/bpf/const_fold.c=0D
@@ -174,7 +181,6 @@ static void const_reg_xfer(struct bpf_verifier_env *env=
, struct const_arg_info *=0D
                u64 val =3D 0;=0D
=0D
                if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_=
addr ||=0D
-                   map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY ||=0D
                    off < 0 || off + size > map->value_size ||=0D
                    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {=0D
                        *dst =3D unknown;=0D
=0D
--- a/kernel/bpf/verifier.c=0D
+++ b/kernel/bpf/verifier.c=0D
@@ -5816,6 +5816,8 @@ int bpf_map_direct_read(struct bpf_map *map, int off,=
 int size, u64 *val,=0D
        u64 addr;=0D
        int err;=0D
=0D
+       if (map->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY || map->map_type =
=3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)=0D
+               return -EINVAL;=0D
        err =3D map->ops->map_direct_value_addr(map, &addr, off);=0D
        if (err)=0D
                return err;=0D
@@ -6370,7 +6372,8 @@ static int check_mem_access(struct bpf_verifier_env *=
env, int insn_idx, u32 regn=0D
                        if (tnum_is_const(reg->var_off) &&=0D
                            bpf_map_is_rdonly(map) &&=0D
                            map->ops->map_direct_value_addr &&=0D
-                           map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY) {=0D
+                           map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY &&=0D
+                           map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY) {=
=0D
                                int map_off =3D off + reg->var_off.value;=0D
                                u64 val =3D 0;=0D
