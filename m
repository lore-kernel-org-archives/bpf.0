Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA023009CB
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136095; cv=pass; b=QBpHjrO9d1STFDQX1OeRvpPWcoEhLVAERIA9YvGsjBNvvLlUA9oYPvXvroku4F8dzYZ+38DV99WO4XCiFxY/XYqMriSqpb1vXmDYc3MRIoBKumNVm5cVZMXo225P+2KmrtOZp2HTfEUU++wZn+nsm7EbFs/rHUkPs5wmOF2v9VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136095; c=relaxed/simple;
	bh=92ifLkSB1QdWZYuCe2bJNqdGfTWsYwdd5FnM5cH+Uek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0pqorzJiW3Vm+uAtf1eeQc2GA0ZPP0bWIRPyhafpgW2Zh/CadW5TwlbpLS0wkmJFbfFMa9b231YMKE/T4rJ/7wRuBe7RlfmrTbBLQt0fBXNiHroX714xfyzwcsdclmdZLFSHlEnCc1X1v187ZA0NGCSPT4qquHZUFWeetG0XVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm440UxV; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm440UxV"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ee82e853cso655162d50.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 06:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775136092; cv=none;
        d=google.com; s=arc-20240605;
        b=DCgyQoie/iGEtBCkLIGNkxlv75misnJJji0yaRAs6gU6zX0saxYubHCy7Vy8S19LlD
         SfXWSzpOVJU1ARScx8MaTWoafZmUnWiBcXAvX3DhjgMYmFANMBLHyRGb3wH0routxNWU
         mav8Ti+aC+oWXGFj6/tAj1TusG5BdaTsGQ6Wpx7l+49Lf0rING6XznGfk4ujxR/Gtld7
         Od8PZ/n75hXMCSu901S9dGhkp5MWQz3bRBJ+YJWlHcX+yvkhDidMhD59JQ5g7a4uZHIF
         EWkutZA1XVkxuYYQw1lxGvaGBKrj2ejLhgA8TkarOEPKu4pi6Q+CYX++eX0EytJ4AzIJ
         P+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/+RvF4sr+15hFwCy/1QY5L6R+YF2MZZgsand9uX2p8=;
        fh=gssCAjqGyG6J0K6pUJfxMkisdYl+sxSjGThHJo71v3o=;
        b=Or4K0GR+xJUE2ZRyCbM5z33JK1OcUJW8Q7lHwddNNqS4VzuYKMQVRK7tWrnmBViecl
         +0yaTpjfcrZm2QQo5yczzsG4SHzr23Y5BfAq5sMYXBhWmYn0S9I+HoQ3R9jOvjgrdbH/
         24k9KXlKxOQGws9Y2e78NetUqU3Or/LKo7yvYQsGpbQStKY+st6LEchOT2raRhcfonXJ
         4vim4xGGSNOosw9yZOUJxVEJtppfSYcaEPQg3xOVtehFhh4zKuoHmSYvRDO+hEKgA184
         SC3v+AXiudp76h+cSySOrffvuQcZjTlXomRW2JeoHfY9mFAIMpfbB3G7po4mwZppB24G
         Vxiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775136092; x=1775740892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/+RvF4sr+15hFwCy/1QY5L6R+YF2MZZgsand9uX2p8=;
        b=bm440UxVqOnXh6b79oWalrfPhYQW4Z4WKNgYdrdUK1TF6rlQ+wO//yT5nDSYwBpe3M
         3MYDe4jfdPdbEl7PS44Kgmpq8yYKdubvQ47hwwMqs53YJ80dz4kjNeLojz5hgjx3XwTU
         gJaFWlU6BeYPAubFhHOeQxQ2cuypCd4CETGTOo0weQaD/vJX41vy10Sc9AtyZyljjU+r
         rLorbuhQ4KlOzPJRLkwqiSgpLGB+PKnB6jKEE8KraTzJfylZ1LVZ7FOcedxsx40wpDEl
         L4qV9CCZs7MVqHczcsg5xWjAXt48v3RGnbBt9YoZ0YiMnmCIkOjkqIKWS3OZwkje6GRN
         JbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775136092; x=1775740892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/+RvF4sr+15hFwCy/1QY5L6R+YF2MZZgsand9uX2p8=;
        b=stzzZAFRJaXfc6L7TrFs2cRec1khal9TTKToRu0owx8yIsABac+6ya5lTTdPrMV/R8
         UFvzZJQWCh3U++4CyjizjPEnV/cN78W65cAIK5LAOZLgjakY+a55jfveXNeaQ6lqn+on
         pudhzzgRty8/TnyGy+C0cJwwE1Q8O4iW1zUuN+y9CC0HnmOEYFP0kE3Eeez/eq4hTRpR
         RvWSgPSIM/uJUC6Ewe/6etZNBaWUY5jcsFAMyYIsWYUSI//Xy+UqCjL3uZJWt4Rhyefv
         RL6Dc5u2KWyQxHn3FWx7fldLuzuvj72zDOLvlYcIBFN+eh42jU1YGLirjmCTcsQwCtIs
         bAGw==
X-Forwarded-Encrypted: i=1; AJvYcCUvrFGdnS+tvF5YxPaXI1o6hgH+IJEjE/QGEeBVv49g2JewYqbvqOYRdjornNoI91TxnuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwhAkHDWc+KqnklDUIzAwrMeCvdAPv463VXzkObnO5EAiK1Tqx
	AALvNVIpZDDE+E+LVLnxe96mfjHEI6hQIs/j6j1INzA8T8vIK7UhrY+9Hq5yQmMvQ+w22Uxt6G7
	UmBhv0DcJOh84foEQsqrHSf6nNaOf86o=
X-Gm-Gg: AeBDietCUS8LZq/YnVYhr7sMV/73Fw3dQyiOTe3BWS53nuGty+iWgKgx2YzCvt37CDv
	FqneJXYoVQi+69WHNs3nKO5KEYWPR5EMFyd8ORwHPK5rCSi/IQwl8Gf9GejE6PojYE6Vdl4ceYb
	6JcaBtgA9QwTVbtAq7Zq/mlAD+gGPr64VHD9ydgJ10FpWmYweCh0PlZfcx9nLYXvbMQ7K587xjy
	l2N+7PBQcKnrcNcIIJYxWoGq9FDBslC0JvGyV+hZamziJtbnN2RkR4DHUZG9fVZycb7tzdgUX37
	SjkKpWOn
X-Received: by 2002:a05:690e:144b:b0:649:bbf4:121b with SMTP id
 956f58d0204a3-6502fd9534cmr7636575d50.2.1775136092404; Thu, 02 Apr 2026
 06:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-3-laoar.shao@gmail.com>
 <2261072.irdbgypaU6@7950hx>
In-Reply-To: <2261072.irdbgypaU6@7950hx>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 2 Apr 2026 21:20:55 +0800
X-Gm-Features: AQROBzCq379oCyNjtOYZmuBoMyOqOT1_VV-wnZMWv4kRMd3OjGsW1s1XAyz2G-0
Message-ID: <CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqgeo4C0iA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
To: Menglong Dong <menglong.dong@linux.dev>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 8:48=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2026/4/2 17:26, Yafang Shao wrote:
> > Introduce the ability for kprobes to override the return values of
> > functions that have been livepatched. This functionality is guarded by =
the
> > CONFIG_KPROBE_OVERRIDE_KLP_FUNC configuration option.
>
> Hi, Yafang. This is a interesting idea.
>
> For now, the bpf_override_return() can only be used on the kernel
> functions that allow error injection to prevent the BPF program from
> crash the kernel. If we use it on the kernel functions that patched
> by the KLP, we can crash the kernel easily by return a invalid value
> with bpf_override_return(), right? (Of course, we can crash the kernel
> easily with KLP too ;)

Right.
Livepatch already grants the power to modify the kernel at will;
allowing BPF to override a patched function simply adds a layer of
runtime programmability to an existing modification.

>
> I haven't figure out the use case yet. Can KLP be used together with
> the BPF program that use bpf_override_return()?

The two mechanisms do not target the same entry point: whileKLP
modifies the original kernel function, bpf_override_return() is
applied to the newly patched function provided by the KLP module.

> The KLP will modify
> the RIP on the stack, and the bpf_override_return() will modify it too.
> AFAIK, there can't be two ftrace_ops that both have the
> FTRACE_OPS_FL_IPMODIFY flag. Did I miss something?

Correct, but as noted, they target different functions

>
> It will be helpful for me to understand the use case if a selftests is
> offered :)

Here is a recent use case from our production environment.

- The livepatch

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index e378bbe5705f..047e937bfa6d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5175,12 +5175,22 @@ int bond_update_slave_arr(struct bonding
*bond, struct slave *skipslave)
        return ret;
 }

+/* noclone to avoid bond_get_slave_hook.constprop.0 */
+__attribute__((__noclone__, __noinline__))
+int bond_get_slave_hook(struct sk_buff *skb, u32 hash, unsigned int count)
+{
+       return -1;
+}

 static struct slave *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
                                                 struct sk_buff *skb,
                                                 struct bond_up_slave *slav=
es)
 {
        struct slave *slave;
        unsigned int count;
+       int slave_idx;
        u32 hash;

        hash =3D bond_xmit_hash(bond, skb);
@@ -5188,6 +5198,13 @@ static struct slave
*bond_xmit_3ad_xor_slave_get(struct bonding *bond,
        if (unlikely(!count))
                return NULL;

+       /* Try BPF hook first - returns slave index directly */
+       slave_idx =3D bond_get_slave_hook(skb, hash, count);
+       /* If BPF hook returned valid slave index, use it */
+       if (slave_idx >=3D 0 && slave_idx < count) {
+               slave =3D slaves->arr[slave_idx];
+               return slave;
+       }
        slave =3D slaves->arr[hash % count];
        return slave;
 }

- The BPF program

SEC("kprobe/bond_get_slave_hook")
int BPF_KPROBE(slave_selector, struct sk_buff *skb, u32 hash, u32 count)
{
        unsigned short net_hdr_off;
        unsigned char *head;
        struct iphdr iph;
        int *slave_idx;
        __u32 daddr;

        __u16 proto =3D BPF_CORE_READ(skb, protocol);
        if (proto !=3D bpf_htons(0x0800))
                return 0;

        head =3D BPF_CORE_READ(skb, head);
        net_hdr_off =3D BPF_CORE_READ(skb, network_header);

        if (bpf_probe_read_kernel(&iph, sizeof(iph), head + net_hdr_off) !=
=3D 0)
                return 0;

        daddr =3D iph.daddr;
        slave_idx =3D bpf_map_lookup_elem(&ip_slave_map, &daddr);
        if (slave_idx) {
                int idx =3D *slave_idx;

                if (idx >=3D 0 && idx < (int)count)
                        bpf_override_return(ctx, idx);
        }
        return 0;
}

>
> BTW, if we allow the usage of bpf_override_return() on the KLP patched
> function, we should allow the usage of BPF_MODIFY_RETURN on this
> case too, right?

It's a possibility, but I haven't tested that specifically yet.

--=20
Regards
Yafang
