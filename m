Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580751;
	b=KjzvciXdgJQ+12UVOeVw/pnErHIPJjFkzgBzswJNih9vwmtJC8XyUjqZO3Tp2kPmBC44
	 j9cjmFDxWOr99vYOujO9u8EYMGrVmtFB4glAkNigiYZmlthIAeCAqPanFHrpqnVrpBazH
	 uozo0VqE9qZEcA2JVaD7xA1FdCFZGk/13oN4kPWmJM8o/v4SFNN9SWB3FElGrb/H1Ta6o
	 OfRpdDAX0mBNuWPhmWXR4a8NwrEb3jzg1BbAFhs3gZfu9uASTysRQyqJWJviwPKrRu3O7
	 jo1xuGr7UoJ3FVeNFG7U89+YpODydK0ZtSgQkkcowiXJzmHae2hH37GgYRQ6vsesZtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bTDEnpPeCb23WGIf+9L+jNqO6MEIQYCxGNNbBRGqPIA=;
	b=2r1Oh/Td4Oe5frLE/06X059IgqxlwS9PAu3BHO2Tt1VuN3xx9h85I/AUvBYzwK4dkMvK
	 Ud9a65X2J4xiXL0k5YYVNty4l42I1FM35r/vcvNAngHf2gLgkB86EHB741JfR+Xc3wgYu
	 zDCjqIpRZgppHwl/TH2qaesPJImzyWq5PTHdKaVXQBUZ8Zr5HM6sLfD+YieGA/I5EaPny
	 +YOY9mf3XYaCnfI+lCfbzorRTiGuiOYPaoOmdbdncAsXHcMcGfAYs0EWS2oVveeFi2Wlp
	 oxHevAbPiNHFnFGV/rXja6vcGW66SZL+Gw2jEnPludpOYVeQ2bsuL6idoXTk/BH/FFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gc/xVqLD";
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E73606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E73606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gc/xVqLD
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f04b676219so29075065ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580750; x=1796185550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bTDEnpPeCb23WGIf+9L+jNqO6MEIQYCxGNNbBRGqPIA=;
        b=Gc/xVqLDzTMXlMMy9RXVPwR6yGVCRvStDyMXKzkOR0PF3xSvURHhVvLNDljr9xvj47
         x54+Q9cjP8acT2wc3VD5t+D6r01sF8CUke8mIc8KlV86JE4o9pM00cwmhVbDCAU0RJMI
         6Ta8e+FJxpaxr+o1AI0N1WOXke1t4llTQKR2aeZQmewULXJwum0cVH7eMSgNeCcJNh9m
         a6NtyYKXz60t/C2+VcL95LLgZU+pB09T+CKY07w2ifY6Dz/Jzwz+s2iElKtwpjvJzbGf
         +PMLT6flnLTpqOWhsHDoUIHm6zx9rb7H2Cx7OI7elfMNYzlS4cl58dQiFUT1qUuv7e6F
         hxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580750; x=1796185550;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bTDEnpPeCb23WGIf+9L+jNqO6MEIQYCxGNNbBRGqPIA=;
        b=FCEAOTlczEvDlu2hEFdxEsfOgIdP1XPJTmWnwxmmuF22tPStfOk1QMFKJNKkOlYDe9
         hEq/aQuWtAOAxcsCZ7BR0lRAFIu3GRawk76Hzqt/UXWd7Y4y/NqLzjPpwjKL60odWDIn
         PyV4z2h4dXULT/0m+Rr/Qa1PiIk8Godci363ocT7LxIvA0vr/0gzv6GrdEWraaNF+m4K
         3kP/49I1fpEJtlDTQirt6a6ynxL/GmlFnaxSVNsY4u4RT3q3Gn35+4nOk++rUuLQbJeS
         n+6tfVTGStwWd0fLcMMTasfRk5QFIOuC0w0nqei2W87Ar5yu09kFMDQfy3lfJnQJsXJj
         23tw==
X-Forwarded-Encrypted: i=1; AL+hErGRZ/wBy315OD6PFiGc1ocbw3w9QrRcc8w2+DFX0ny72JBoSqcO3r0z5luGndpJ/EJZbbk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sAgORK9Q8kSbNs1EEKxJTMa8GjPkxPuDQYGCfYFvjGFiOKlso
	dpWfI+gkhJ2lEQwwQSN5tweUm8E+F/vTmsyGfpcRl/EBAPTl61ZiNOi+
X-Gm-Gg: AZFdTZcdK04WPYPuewGjGyuafAPqb3nRbNX/mZVRJGU54tgk7rK/Dwk4NPVhFwyFjZ+
	5J/8KFxJ5I53DI2iQLO/4GRCwgGSaOqgmtnLdQNYA3PugYIRDFD6Y7UVcDYwh+Zdu1cASijCrvb
	JZ34q6f/OeIWaatrI5R+Jx1cJohvm5NlmaKhhaCbOnz21H4re5c8xE+yes5eRwQOdtl3/jwvApY
	O3fNoFw3l+Fgb/CWTk8jCd3NB4kZrA7oPal0Gx4sNv+NZ5wP/hlLlwKxxiiDhQCyTwOA8IVmirJ
	gWUpntECbnG85gn6shTBtuMylLb8PMDK7EQ4TrUE1DL+lxs0ySCj0JlHqWZU/V91UFr8v/4gDqb
	DCiS6cKsoa6vXm3DSR9UYkxyLLrbqvLjQM8lHTlKPFYGG+GLTBdXCbJi1jXlZfJ3fUblHdU2Al6
	kBOh5G+aE9NMU6V3nK51j5f1pObInFh5LSemeWZAPrJVqS1WZ41fbDeMDuRIB7akB+cFuFCC8Y4
	Km/Lj3jf4gB+AcHJkjxL9Um9QGk05BkzE5fOYoKgDvy2LGYkq8uwy/HF8G0Iy/TiLLgJoVnDHxW
	syKAtnqd3PGHuisiP9u88u/Cpaw8TYEm6rUqGe3nBSiqSq4gaDK79w==
X-Received: by 2002:a17:903:f83:b0:2df:8f19:5db8 with SMTP id d9443c01a7336-2f03f1d09e3mr160319915ad.59.1795580749927;
        Tue, 24 Nov 2026 20:25:49 -0800 (PST)
Received: from srsys1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1215d7sm76117185ad.65.2026.11.24.20.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:25:49 -0800 (PST)
Date: Wed, 25 Nov 2026 04:25:41 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Amery Hung <ameryhung@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, David Vernet <void@manifault.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH bpf 0/3] bpf: Reject sleepable struct_ops programs in
 atomic context
Message-ID: <awZjRcsJ30sLFpc2@srsys1>
References: <20261124143123.1182108-1-rhkrqnwk98@gmail.com>
 <DN3QWUNLDYAP.1RWBZ8RJH1QSY@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DN3QWUNLDYAP.1RWBZ8RJH1QSY@gmail.com>

On Tue, Nov 24, 2026 at 09:06:37PM +0000, Alexei Starovoitov wrote:
>On Tue, Nov 24, 2026 at 06:31 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>> atomic context. tcp_congestion_ops, Qdisc_ops and smc_hs_ctrl have no
>> check_member, although the kernel calls their members in softirq, under
>> a spinlock or under rcu_read_lock(). A sleepable program attached there
>
>Not all of them. Qdisc_ops init and destroy run under rtnl and can sleep:
>
>  qdisc_create_dflt()
>    qdisc_alloc()                 kzalloc_node() with GFP_KERNEL
>    ops->init(sch, NULL, extack)  no lock taken in between
>  __qdisc_destroy()
>    ops->destroy(qdisc)           fq_codel_destroy() takes a mutex here
>
>A sleepable init is valid today. bpf_arena_alloc_pages() uses GFP_KERNEL
>there instead of alloc_pages_nolock(). Patch 2 rejects such progs.
>
>> This series adds a check_member that rejects sleepable programs to each
>> of them, like bpf_tcp_ops does.
>
>That makes four copies of one function. The default is the bug.
>bpf_tcp_ops v2 and blk-iocost v1 missed the same check:
>https://lore.kernel.org/bpf/20260623175006.3136053-12-ameryhung@gmail.com/
>https://lore.kernel.org/bpf/178889947167.2.9168058946538747939@kernel.org/
>
>Fix it once in check_struct_ops_btf_id(). Patches 1 and 3 go away.
>sched_ext, hid, io_uring, binfmt_misc and bpf_dummy_ops have
>check_member already, so they keep their sleepable progs.
>A struct_ops with check_member still has to test prog->sleepable itself.
>
>In place of the series.
>
>diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>index 1dd9db1..f7c7380 100644
>--- a/include/linux/bpf.h
>+++ b/include/linux/bpf.h
>@@ -2209,7 +2209,8 @@ struct btf_member;
>  * @check_member: When defined, a callback invoked by the verifier to allow
>  *		  the subsystem to determine if an entry in the struct_ops map
>  *		  is valid. A nonzero return value means that the map is
>- *		  invalid and should be rejected by the verifier.
>+ *		  invalid and should be rejected by the verifier. When not
>+ *		  defined, the verifier rejects sleepable progs.
>  * @init_member: A callback that is invoked for each member of the struct_ops
>  *		 map to allow the subsystem to initialize the member. A nonzero
>  *		 value means the member could not be initialized. This callback
>diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>index 01a74e1..42a90c7 100644
>--- a/kernel/bpf/verifier.c
>+++ b/kernel/bpf/verifier.c
>@@ -22244,6 +22244,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
> 				mname, st_ops->name);
> 			return err;
> 		}
>+	} else if (prog->sleepable) {
>+		verbose(env, "member %s of struct %s cannot be sleepable\n",
>+			mname, st_ops->name);
>+		return -EINVAL;
> 	}
>
> 	if (prog->aux->priv_stack_requested && !bpf_jit_supports_private_stack()) {
>diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
>index 2ba73dd..4e54165 100644
>--- a/net/ipv4/bpf_tcp_ops.c
>+++ b/net/ipv4/bpf_tcp_ops.c
>@@ -301,16 +301,6 @@ static int bpf_tcp_ops_init_member(const struct btf_type *t,
> 	return 0;
> }
>
>-static int bpf_tcp_ops_check_member(const struct btf_type *t,
>-				    const struct btf_member *member,
>-				    const struct bpf_prog *prog)
>-{
>-	if (prog->sleepable)
>-		return -EINVAL;
>-
>-	return 0;
>-}
>-
> static int bpf_tcp_ops_init(struct btf *btf)
> {
> 	return 0;
>@@ -329,7 +319,6 @@ static const struct bpf_verifier_ops bpf_tcp_ops_verifier = {
> static struct bpf_struct_ops bpf_tcp_ops = {
> 	.verifier_ops = &bpf_tcp_ops_verifier,
> 	.init_member = bpf_tcp_ops_init_member,
>-	.check_member = bpf_tcp_ops_check_member,
> 	.init = bpf_tcp_ops_init,
> 	.validate = bpf_tcp_ops_validate,
> 	.name = "bpf_tcp_ops",
>diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
>index 5691c13..61a1971 100644
>--- a/net/sched/bpf_qdisc.c
>+++ b/net/sched/bpf_qdisc.c
>@@ -356,6 +356,24 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
> 	.gen_epilogue		= bpf_qdisc_gen_epilogue,
> };
>
>+static int bpf_qdisc_check_member(const struct btf_type *t,
>+				  const struct btf_member *member,
>+				  const struct bpf_prog *prog)
>+{
>+	u32 moff = __btf_member_bit_offset(t, member) / 8;
>+
>+	switch (moff) {
>+	case offsetof(struct Qdisc_ops, init):
>+	case offsetof(struct Qdisc_ops, destroy):
>+		break;
>+	default:
>+		if (prog->sleepable)
>+			return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
> static int bpf_qdisc_init_member(const struct btf_type *t,
> 				 const struct btf_member *member,
> 				 void *kdata, const void *udata)
>@@ -446,6 +464,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
> 	.reg = bpf_qdisc_reg,
> 	.unreg = bpf_qdisc_unreg,
> 	.validate = bpf_qdisc_validate,
>+	.check_member = bpf_qdisc_check_member,
> 	.init_member = bpf_qdisc_init_member,
> 	.init = bpf_qdisc_init,
> 	.name = "Qdisc_ops",
>
>Pls target bpf-next.
>

Thanks, that's cleaner. I'll move the check into check_struct_ops_btf_id()
and send v2 against bpf-next tree.

Thanks,
sechang
