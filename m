Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4331195B
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118501; cv=none; b=au+6lLkvbJh1ZcaqZNDm1t1CMFS9cbnZsmltHXtH0EBiAJ/BfgDXoKf0I50i7f4iRyrfnYBZEIEjDpK119ObGAr9lpMsit9BuCMzsEPe8njeQo7+clCVL/o0EdExdV0K75ntoOC/yYyurGvoFAticSdoq7znl9lTaTtYF8PrMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118501; c=relaxed/simple;
	bh=Fs27wj3NEjB25ZPCY7DQNO0nTkL6l1gERrvD6jXpVrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTHpgHNV0UWFvj5PQ60Ad8MXi0YlNmqw7eAlo05GJjUhzXWIXr3LSFK/CxaL+V49umYb3Wm6lcTtPlK24ElhV/M+A+U8Nfy7tUn+nhu4tLL24LXCFr6LoTnpS38u7UZgVlh0wzTASyicu21nymn+BNtWcXT8RL2Y4Fe13WZjCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxo2CyHm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxo2CyHm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486b96760easo6298095e9.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775118499; x=1775723299; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FPKVicoVCtL8negzU5Je7I1Uttyzhv1OjefJ6mOXeaU=;
        b=nxo2CyHmKB2K0Bj6pbvzkK64XFmrm4irsCdEiYyfXWtHFx4UaerLiyxmmxlFDjzEVp
         mY1QsrqX12+lmMxtomN8p6MpxVLKI+SxCXGpDWTU32wD0Yoog3IEX1fdmu83k1YANmok
         u1Fi2KuBstw3rmEr1bwKhcku+FU5QOygH5sj/JpiO+KPSGoGSGLwsE17lnSysjHu/ebH
         2yHAAkaNORkP/3kWmMTFPQJ/ZQI1/y84O/HeufRDQz0HttmKeWiMOBhYx4ULQcOVlEtW
         b5JC64TJPMkvBaU4hK0O45chhwMgar+gDuzCFKUkvwMoK0DXetujUu2Ar169ydpFsyAs
         Drvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775118499; x=1775723299;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPKVicoVCtL8negzU5Je7I1Uttyzhv1OjefJ6mOXeaU=;
        b=Zq3XTQucOBPFAPfYb4LqVNR+AHq0Lwhkp99SDp7QkUwXK54JCznGaDk8/2nTcbuxR2
         SoQ4hrLHDmJlR+GhW7QXZZfMTkVpLThGJHxl49W4/GTICKmT9PflHwJ2M4u38pyWaIlD
         LMAKf0mJtKTCuivZDv3jbrKSe4U4b7ilffT6GFnKTYl611bq88nFGx3B8TVteZS0I/qD
         DfXJNvQT70HfdkhL88fWSr1KHylNmZwEjhWVtnuCPhrGXK948qfQuKKeh3fwiH7XVuzb
         codxm+W3yh4HaFID/OV4bMgZybJFLV7c9vUaDFIGJxBBz76styGi35xYxFtc76jySRvZ
         8L8g==
X-Forwarded-Encrypted: i=1; AJvYcCW/HtZigg4Vxt/Y/D0kLRtxzpYKujU+D87oMJd16K9776Q27uWDcKGLIUFBlq9VIkbrHXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7uP6H5R45XaItBp+EOmSv8wg/f0RfdqUUEqgTOjTkS77+Q6w
	hasmGqjtzrdkAn0CfmZZk9uix00aifagQ8307ycr/g5AkP1Xjm0TCev/
X-Gm-Gg: ATEYQzzgVxgDCgyG88Hi5nzSvd/OPBX+huKCgNnfII9PH9ISoo7MIl+dPQBZaiJWNDo
	yDnhE0Bvuhqkl6SR93aS6Dvc4g6+AV94Qbmka7/FXSNuhBHVCLaEFTpVKVSvP6nkG3d1E6x7MOS
	35xWnekfN1PYcFwyaj+EgCAgCIiXZJee92blqi3s54YxW4JIL1YAhzLd4eUSoki5GogxZPXbxau
	e5xrO6hqBuPBTlVI7vYRT0WLcIkUSqD1ar7Evo/136g0xvgV20mgNYNgNIY0j2ubluexfCwLWE4
	WSSXetSdCbESeEqbUl9mHG33EDJksXjKb01TTISc9VijqDYcaiJ4Mio4jDO+JUNf5R0T9c00wpE
	LbW8MCgpvtUSN/Pnl45wS751uYCXYtTnK/40nPc6xcAfHQPex6s8OptQBH7hWcYHgFi+SW98y0O
	DEtyzf/hJ+8kmVHl9bk7JGVVP0k5l7q86n
X-Received: by 2002:a05:600c:1798:b0:488:8bdd:cfde with SMTP id 5b1f17b1804b1-4888bddd1bemr21845405e9.7.1775118498714;
        Thu, 02 Apr 2026 01:28:18 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e6224sm6378978f8f.25.2026.04.02.01.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:28:18 -0700 (PDT)
Date: Thu, 2 Apr 2026 08:37:04 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not ignore offsets for loads from
 insn_arrays
Message-ID: <ac4qsK62eCNvmneu@mail.gmail.com>
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
 <20260401161529.681755-2-a.s.protopopov@gmail.com>
 <823cfd94-a35d-4f99-afa3-238fb1e9862d@gmail.com>
 <CABFUUZFZf5nUoQr7v-fp5k+Ef+q-XtzxVcsbYMfS-zsk2zdRbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZFZf5nUoQr7v-fp5k+Ef+q-XtzxVcsbYMfS-zsk2zdRbA@mail.gmail.com>

On 26/04/02 10:37AM, sun jian wrote:
> On Thu, Apr 2, 2026 at 6:47 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> >
> >
> > On 4/1/26 5:15 PM, Anton Protopopov wrote:
> > > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > > specify an offset inside the load instruction. This is a bug,
> > > because while the verifier ignores the field, JITs are not.
> > > So, patch the verifier to not ignore this field.
> > >
> > > Reported-by: Jiyong Yang <ksur673@gmail.com>
> > > Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> > >   kernel/bpf/verifier.c | 17 +++++++++++++++++
> > >   1 file changed, 17 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 8c1cf2eb6cbb..f1b1c8e9dc26 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -212,6 +212,8 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
> > >   static bool is_trusted_reg(const struct bpf_reg_state *reg);
> > >   static inline bool in_sleepable_context(struct bpf_verifier_env *env);
> > >   static const char *non_sleepable_context_description(struct bpf_verifier_env *env);
> > > +static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
> > > +static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
> > >
> > >   static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
> > >   {
> > > @@ -7735,6 +7737,20 @@ static bool get_func_retval_range(struct bpf_prog *prog,
> > >       return false;
> > >   }
> > >
> > > +static inline void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
> >
> > Why does it need to be manually inlined?
> > Other than that the change looks good, the implementation of the
> > add_scalar_to_reg() is similar to a piece of code in sync_linked_regs().
> Agreed.
> 
> nit: maybe this helper could be called from sync_linked_regs() too?

Looks like out of scope for this particular patch.

> >
> > > +{
> > > +     struct bpf_reg_state fake_reg;
> > > +
> > > +     fake_reg.type = SCALAR_VALUE;
> > > +     __mark_reg_known(&fake_reg, val);
> > > +
> > > +     scalar32_min_max_add(dst_reg, &fake_reg);
> > > +     scalar_min_max_add(dst_reg, &fake_reg);
> > > +     dst_reg->var_off = tnum_add(dst_reg->var_off, fake_reg.var_off);
> > > +
> > > +     reg_bounds_sync(dst_reg);
> > > +}
> 
> > > +
> > >   /* check whether memory at (regno + off) is accessible for t = (read | write)
> > >    * if t==write, value_regno is a register which value is stored into memory
> > >    * if t==read, value_regno is a register which will receive the value from memory
> > > @@ -7816,6 +7832,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> > >                                       return -EACCES;
> > >                               }
> > >                               copy_register_state(&regs[value_regno], reg);
> > > +                             add_scalar_to_reg(&regs[value_regno], off);
> > >                               regs[value_regno].type = PTR_TO_INSN;
> > >                       } else {
> > >                               mark_reg_unknown(env, regs, value_regno);
> >
> >
