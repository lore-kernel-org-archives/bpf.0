Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FA3F6C2A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243307; cv=none; b=mIpB9hiTOY8y0cFGjwtLXmfblL2G6xw+qReuh+xy6vqp9IHIxjed982plbJLLS7TQ80WR6QhF1uT0ukx+F1MAapSiorIuZMKqIu6q8qHLMU5LvmKiUp+2rV62pQjLM0uc9vX2IyofZb3p/FZNX+7/cIVzU3PTdtzZNuzxFBwKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243307; c=relaxed/simple;
	bh=HEeUd+LSqVw5hynFy7d5WxUSYyIFITCcanCLFiiRq9k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVrPNUdn105QxdlsmjcQw3AWFKEteXCv2rxPgTl0xv6YnNQNiH2BlMMngU06mH+8+p7va4KvgQah/m4amGpTmU2Cw3HceWLdPg9ayx3KzypXJv+/m0G20a9iVOYGlOSBWalPa8xRLeIkMXZutGRU2nDSX9AWQY9tnZxg+13Mwqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRbzQyKa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRbzQyKa"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-488615e6cfcso302202f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243296; x=1790848096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UXZ9XUc1fFWwTexSbP5UtcuqGHX4d6cpGE1SNbJUFEU=;
        b=jRbzQyKa2LcUrzkvfIhgdjfphY6Nfwr1i5EaytP0sFL/a6LeFKLet0O6C/tdvommzv
         hpa9O+YGmH4wVV1BbAi3QbzlquMxCyn9sD7QuNTMMimNnolO7qb7ZmmN2gtITXCKzmLT
         I+1K8Dw8FqRWrXP13tRfrjXZoG2hUpVOJG4es1MfMQttLLs5fxV8crYa+v3wNQm4bWZu
         n536gGOjmS8LMNPSKGC7a+/6KwzCmrIREAFXAeNdQR6Wjij43vwo+2faiQAN3VqGfe/T
         j2PckwRqzeNdd8ppR9Acs5R/lEK9Yo4gnzPrfsb380qFV3fW3GgNYbE5dLdqnnM7qmrV
         oaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243296; x=1790848096;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXZ9XUc1fFWwTexSbP5UtcuqGHX4d6cpGE1SNbJUFEU=;
        b=P060liXLzu4CgZu4hy6XbH5hIDq5iCsTS8P7BxMLha84wlAAv/sQmt296D0NQ9XMvT
         hlzx9WGP5e0Gn3im8rnq2FY1QYCzvTsMo6XkaMLXy2fNv5MSRyKrlDuQY4vbiL99nHpF
         36HbKktqS/eFCI7Mo+Gef9X5S2oc8T5B6O4Pd9A6F4k4hck/g/ypsV955WOwFxuTmNh1
         UsHfx0zzd7QqyKkneSaJ2rg5yUaUWgBA1xPyNi11rSVn+zx0ej5siqtQlmdSITM2E521
         YyjrXaScbY4aOafNZaaoOV8GOoXdu03j58C5Te9/mJGfg3austFxcO1yZEp0aIII6xEI
         Py5w==
X-Forwarded-Encrypted: i=1; AKwUvBxpofoXcMDJWQDnaxD3+C14TYiWfPxggXk0HP0mPI0cPgnHPd+wxXgiA9XjVybJgfIwZGo=@vger.kernel.org
X-Gm-Message-State: AFuF++lKfgqogfV7mA00CihkdpZfG+ozn+zLa+xf81/YNcAEvgrBuBIH
	UvtjNB/qoHCVXbTE5hbEo+0WZGq1rmcvCRNo01/uUNn3xDXetKB0wiMJ
X-Gm-Gg: AYBFou3zCekhvlVXVyalwl8gb0ibgrUDPr1oLJ9/KmmxNzYZ/IbqoBGjDWAm55hfu0+
	dHfB//IaYuLVWCLrGllqxUVNholegKaW5H9oaIzX07lKDIVb5y6mYCChRmrmABMIu7GG6fzNCsC
	IEC5uBNsDbxg8UgNgfrgtwikCUGlJ5lVdhY3bG9HlVeYgiUv0FWh+q0pwiQQyh0+Yy396oh/mst
	KnffRZUnt6FlEtUIJ9okpSZS8clglEk0Ak6KuR66/JX80CgGd/tWmOOXVA0oWIdmD1bvXhDiOks
	4GkuF0G9a9UKhGujoF6ZNhmNhaTlSKGmtlCJxp9f5YoFSPhvijcyOh42r0TRDEDepZzN3e9ievj
	fUboMNhIaZe0h5IQtXXMGsLUtOaf3nXekK9ABQf7nf/m6Vc1tHWiWB3owLc/UfCGmr8ys/D7ZV3
	D7uWD4ynNnmycVXiUBY39SimRr5I9iTXID0JfwgasyiNhad1t9l4i06NyKng==
X-Received: by 2002:a05:6000:4013:b0:487:22b1:e511 with SMTP id ffacd0b85a97d-488716af28amr3701541f8f.9.1790243295567;
        Thu, 24 Sep 2026 02:48:15 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c64dsm13751435f8f.21.2026.09.24.02.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:48:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Sep 2026 11:48:13 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: chenyuan_fl@163.com, alexei.starovoitov@gmail.com, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	yonghong.song@linux.dev, john.fastabend@gmail.com, song@kernel.org,
	ihor.solodrai@linux.dev, Yuan Chen <chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Keep target extended until its last
 freplace link detaches
Message-ID: <arTx3bjNv_BZcQ9K@krava>
References: <20260924023737.1140521-1-chenyuan_fl@163.com>
 <20260924023737.1140521-2-chenyuan_fl@163.com>
 <d3e65c94-45d9-4c67-a276-103c5e7fa052@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3e65c94-45d9-4c67-a276-103c5e7fa052@linux.dev>

On Thu, Sep 24, 2026 at 03:06:16PM +0800, Leon Hwang wrote:
> On 24/9/26 10:37, chenyuan_fl@163.com wrote:
> > From: Yuan Chen <chenyuan@kylinos.cn>
> > 
> > The is_extended / prog_array_member_cnt protocol introduced by commit
> > d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")
> > keeps a prog extended by a freplace program out of prog_array maps, and
> > vice versa: once a tail call re-enters an extended subprogram, its
> > tail_call_cnt resets on every execution and the loop never terminates.
> > 
> > But is_extended is a plain boolean, while one target prog can carry
> > several freplace links at the same time, one on its entry and one on a
> > global subprogram.  __bpf_trampoline_unlink_prog() cleared is_extended
> > whenever *any* freplace link detached, so detaching one of two links
> > re-armed the unbounded loop through the remaining one.
> 
> A prog may have multiple global subprogs. And each of the subprogs can
> be attached with freplace prog. When all the subprogs are attached with
> freplace progs then detach one of the freplace prog, the *is_extended*
> becomes *false*, which relaxes the restriction between tailcall and
> freplace introduced by the commit d6083f040d5d ("bpf: Prevent tailcall
> infinite loop caused by freplace").
> 
> > 
> > Replace the is_extended boolean with a count of the freplace links
> > attached to each target prog, so the target stays extended until its
> > last link detaches.  Also rename bpf_freplace_check_tgt_prog() to
> > bpf_freplace_link_tgt_prog(), as the helper has never been a pure
> > check: it reserves the target prog on success.
> > 
> > Fixes: d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace")
> > Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> > 
> 
> [...]
> 
> > @@ -933,7 +933,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
> >  		/* Cannot attach extension if fentry/fexit are in use. */
> >  		if (cnt)
> >  			return -EBUSY;
> > -		err = bpf_freplace_check_tgt_prog(tgt_prog);
> > +		err = bpf_freplace_link_tgt_prog(tgt_prog);
> >  		if (err)
> >  			return err;
> >  		tr->extension_prog = node->link->prog;
> 
>                 return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
>                                           BPF_MOD_JUMP, NULL,
>                                           node->link->prog->bpf_func);
> 
> 
> I think there are existing issues here: if bpf_arch_text_poke() returns
> error, the tr->extension_prog and aux->freplace_link_cnt should be
> rollbacked.

+1, let's set tr->extension_prog and tgt_prog->aux->freplace_link_cnt++
only if bpf_arch_text_poke succeeds

jirka

> 
> Thanks,
> Leon
> 
> > @@ -979,7 +979,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
> >  					 tr->extension_prog->bpf_func, NULL);
> >  		tr->extension_prog = NULL;
> >  		guard(mutex)(&tgt_prog->aux->ext_mutex);
> > -		tgt_prog->aux->is_extended = false;
> > +		tgt_prog->aux->freplace_link_cnt--;
> >  		return err;
> >  	}
> >  	bpf_trampoline_remove_prog(tr, node);
> 
> 
