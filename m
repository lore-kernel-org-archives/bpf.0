Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC8385517;
	Fri,  3 Apr 2026 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775211980; cv=none; b=eFdJ44lt0rpiMie0TO+beHp0FwVly2t425BQgkoVfsNO9VF19E8MypXI/4RNQlz87U7+X+ZeynCNhfFDwHAguYvD1WMy/gFpMGj371351HyNpxHZM0FAM5V/6OeBViMaJG4Zcv3P3U0SXQoxqan4wPONdn38HX+XVx+bnpk5GgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775211980; c=relaxed/simple;
	bh=pFuZEqqsnp+atcnjaA2I/DZblQ0NZSospQm7aD6BbAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d05T9EuAWrD4AB4vIMwy+lIuTXYsINfAKQphU/Lc7VLTaH0u3/X/hW7VKd6W6SVYVQMTwHNNqhTopLbwvIxgzB5oXsuANQgNIpEPDbCWQXnX6mbrv15jJW6+GajqdSz3jOI+nYHk44vHi2BAfH8eyMiA4QGexbHUyaLtkgphhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mb+Bd81u; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mb+Bd81u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775211976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9vbmYrgM7p/HdxXpEWjuvrDuFisLQfIER5eZwbQeRY=;
	b=Mb+Bd81uc425q5hX6J9fmhZwcibN69lQKHlnZZ/HzU01DpiGLRe+bDYu2JkBxiKMz1YhOJ
	SF96Z7lGv737ZHbZW/BAnjhq9cvbeziwBCCsUUqOrkZkPvEzYGOw5b9qQ4dshBkyloo0k+
	TtuVHKG2jvvwRUN+fEcEGQliIamzAiI=
From: Menglong Dong <menglong.dong@linux.dev>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
 joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com,
 song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 yonghong.song@linux.dev, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject:
 Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
Date: Fri, 03 Apr 2026 18:25:59 +0800
Message-ID: <3036842.e9J7NaK4W3@7940hx>
In-Reply-To:
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com>
References:
 <20260402092607.96430-1-laoar.shao@gmail.com> <2261072.irdbgypaU6@7950hx>
 <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/4/2 21:20 Yafang Shao <laoar.shao@gmail.com> write:
> On Thu, Apr 2, 2026 at 8:48=E2=80=AFPM Menglong Dong <menglong.dong@linux=
=2Edev> wrote:
> >
> > On 2026/4/2 17:26, Yafang Shao wrote:
> > > Introduce the ability for kprobes to override the return values of
> > > functions that have been livepatched. This functionality is guarded b=
y the
> > > CONFIG_KPROBE_OVERRIDE_KLP_FUNC configuration option.
> >
> > Hi, Yafang. This is a interesting idea.
> >
[...]
>=20
> +/* noclone to avoid bond_get_slave_hook.constprop.0 */
> +__attribute__((__noclone__, __noinline__))
> +int bond_get_slave_hook(struct sk_buff *skb, u32 hash, unsigned int coun=
t)
> +{
> +       return -1;
> +}

Hi, yafang.

I see what you mean now. So you want to allow BPF program override
the return of all the kernel functions in a KLP module.

I think the security problem is a big issue. Image that we have a KLP
in our environment. Any users can crash the kernel by hook a BPF
program on it with the calling of bpf_override_write().

What's more, this is a little weird for me. If we allow to use bpf_override=
_return()
for the kernel functions in a KLP, why not we allow it in a common kernel
module, as KLP is a kind of kernel module. Then, why not we allow to
use it for all the kernel functions?

Can we mark the "bond_get_slave_hook" with ALLOW_ERROR_INJECTION() in
your example? Then we can override its return directly. This is a more
reasonable for me. With ALLOW_ERROR_INJECTION(), we are telling people that
anyone can modify the return of this function safely.

WDYT?

BTW, this is a BPF modification, so maybe we can use "bpf: xxx" for the tit=
le
of this patch. Then, the BPF maintainers can notice this patch ;)

Thanks!
Menglong Dong

>=20
>  static struct slave *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
>                                                  struct sk_buff *skb,
>                                                  struct bond_up_slave *sl=
aves)
>  {
>         struct slave *slave;
>         unsigned int count;
> +       int slave_idx;
>         u32 hash;
>=20
>         hash =3D bond_xmit_hash(bond, skb);
> @@ -5188,6 +5198,13 @@ static struct slave
> *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
>         if (unlikely(!count))
>                 return NULL;
>=20
> +       /* Try BPF hook first - returns slave index directly */
> +       slave_idx =3D bond_get_slave_hook(skb, hash, count);
> +       /* If BPF hook returned valid slave index, use it */
> +       if (slave_idx >=3D 0 && slave_idx < count) {
> +               slave =3D slaves->arr[slave_idx];
> +               return slave;
> +       }
>         slave =3D slaves->arr[hash % count];
>         return slave;
>  }
>=20
> - The BPF program
>=20
> SEC("kprobe/bond_get_slave_hook")
> int BPF_KPROBE(slave_selector, struct sk_buff *skb, u32 hash, u32 count)
> {
>         unsigned short net_hdr_off;
>         unsigned char *head;
>         struct iphdr iph;
>         int *slave_idx;
>         __u32 daddr;
>=20
>         __u16 proto =3D BPF_CORE_READ(skb, protocol);
>         if (proto !=3D bpf_htons(0x0800))
>                 return 0;
>=20
>         head =3D BPF_CORE_READ(skb, head);
>         net_hdr_off =3D BPF_CORE_READ(skb, network_header);
>=20
>         if (bpf_probe_read_kernel(&iph, sizeof(iph), head + net_hdr_off) =
!=3D 0)
>                 return 0;
>=20
>         daddr =3D iph.daddr;
>         slave_idx =3D bpf_map_lookup_elem(&ip_slave_map, &daddr);
>         if (slave_idx) {
>                 int idx =3D *slave_idx;
>=20
>                 if (idx >=3D 0 && idx < (int)count)
>                         bpf_override_return(ctx, idx);
>         }
>         return 0;
> }
>=20
> >
> > BTW, if we allow the usage of bpf_override_return() on the KLP patched
> > function, we should allow the usage of BPF_MODIFY_RETURN on this
> > case too, right?
>=20
> It's a possibility, but I haven't tested that specifically yet.
>=20
> --=20
> Regards
> Yafang



