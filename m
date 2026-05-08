Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D277262FD0
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261637; cv=pass; b=LgxOcif7ljGqPYoAxTN3Z2IIybS6GrqAWahOVL+eRK0WQ7PNoMGHxGkB0P+Xqia8W/dWKx6vN80rO2ALyBiATfc3KAvifSJwfM0hHlktmmaslnW64hZKskAFzEaeh37gVPkVfGDTHIfe4ntkboBTZcjADsIT/kLuAAIcg6Dy+Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261637; c=relaxed/simple;
	bh=Zuzap/NeEJKgBkbnacndJucESuPLdGprQGVJ/QLToEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6VzqC76u5Fuii4puWa6uGt39RWloecNWbNva9siBAxDftBxmndf8jvzKw02jyX+osCT4q91V6nKb0NKNthV/bFe9Dx1jTWVFACg+Yil4LatG1UsavAPKvckinWLAbdaPQZr9CNciUiAJVf587uymqJc+b8A0NIOcOvSK9kvwd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n16aWDo4; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n16aWDo4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso24690765e9.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 10:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778261634; cv=none;
        d=google.com; s=arc-20240605;
        b=kc3rocDoe0mQMqA0CnHRvct8LPdK5WyuEmR98AXZDqXKl8/0WYXnVK+Cn4ln95BxcD
         JnJiwVJ96WEQ6FJ2rSpyocJVdmFXWp6C9L5nIn/FyuDlTnFOH8Sn/Lqemtu4gDhsxYQ5
         lif+CJSC/9z+OsWuB51Z/ZiLWIr1macYJ5+Xaq2mCDrCv6zCxR0yomxztLVvc8544ABH
         cC0UNXeCR41xer1QSzqGkYnYmk5JLvQTTsL2vCu4lQJ0ZrKKqrCkhQXELAF8S+KTniCZ
         1l/8mB4aA+U2JkCdT5RJaFrSE3XZdzER+3JQ2wCf5eIt10yrh8vlcHwFAM5gB/72kUxh
         QF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pYjQZP/Zb8wkT3ptwcSfDCc4VXR9i3KlcImFiXOhk38=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=gjIt7x3lZ/pJzm2/1s+jMgJw/GakaZ1oJXtz9wC/nmR6YP6yoIy6tHWOlPPKF6SFDg
         mkZ5jod0OuIqT5Tq/jiL1MwCJeHvFUK1QRRj+6xj3PsXotTbvviycp4wAWpnXnm9Sz+F
         c75RVXgo21XaOLgcIfcBmBo7FaxL7n1NMhAHP+YnBCdfJ2gIYSZrwGvUcezG4WvOVB/+
         8mJ6ymjsaDkhRKimwSPpcwX+MRB040mun+hT+2fCkBFk1FCOhJ3NPOnbe6Km3FqKGFZU
         UcA58urMGCW2rZH1drtc8kojci2IODcla7mR20/PzCDBT9+3rAjiTaL9bwwHtk401Sov
         nw9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778261634; x=1778866434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYjQZP/Zb8wkT3ptwcSfDCc4VXR9i3KlcImFiXOhk38=;
        b=n16aWDo4Se9jZ7Ex5Tmo9swMUtce00o57rcvWKP7vbwObnHCxi7OtzQcNoNO7915d9
         gjuFwmhYutmYGCZcIxbKvvrWswIOEM52ekotvc+ZHFzwHYExNv5FdgFPzsSmbcLuSxaB
         Tq69t6zJMADTtNSKff99Lyr+kCR46K2yRJIjfpzfQuMhfRtIZUqYvC1cx+eabZKuOB1v
         KYsM8mmycSlLAk8F4Sde1CN7s3ivTBOgwdgqmIzGrE6sMuccNmA+Dq7K+ZLJ34+ifPOe
         zK3KRY++uDz/ouVr6atcLqvGKGLXOZEsRGuBJ1h9u3ayNpwcnBjniQ+vc9SIMN1dffsg
         3Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261634; x=1778866434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pYjQZP/Zb8wkT3ptwcSfDCc4VXR9i3KlcImFiXOhk38=;
        b=RKpyHX6bkewDvwHJXm5nV58O05BOsTGtIjyD+JTDUXkH3KpD4P4ul/QKaPH5SW8b71
         aVMd+G7vVnmKVsIyCpkSIblc3uiXrx6FEimQrDcRL8lmfizcSLn2hyR9n5oW3dz12MDP
         gUC1YRovD9yqJzacfjIELsEQM6xzgRGbCRV5qsMsDJIYAfwSs4EagU3wCw0eaaj6prmN
         9SD00z/M3vRcnjHf90qoJN0AUA6o/DO5EPvPi9LgFudFBl8/Jl2WFeL4jJ+M/YDgLIvq
         h85RbchUh75nPN0NssGG6eVKR0tH+g04BLTKc4qjKU3+uK9/1uvNtPQqiEFJn2MPXmKI
         VYtg==
X-Gm-Message-State: AOJu0YxOI3Oma/QcFWyKdrRsHPnCldJOJmTu77i6vZgw+9u7F8yJuTx3
	GHIS4DJwH64NHvn3DKu6PiNzCIryw1zNv65e8OiWAJ7plgwPmZFjymbPvSAtL3IurVmd98Ptms6
	CL3vBQzy0uJvyx0036AA4wc0Guat1t08=
X-Gm-Gg: AeBDieumTOvtn+fYfcAaBEctBpdzQEwx7jemV1poTKJpo9eBoIbe45ZRb98KFxRYNXu
	+kamSLCQ7w9O7HB6TQb1CoWPl2L3Nxgaw15lpPXzoqGhJBBizd7RhTkN4SLEHdbyJYzXXClrUTl
	iBYofIw8TGpvzDsKpWNgUrxdIZC2Y0+iJOWn2htSDkBemDNzS9BZSqUqKzw5WkhXScrCmysT8Vq
	hSAS8ryachYOuUDr+512sa97ez2ObzALhxPPxmd6kbe9xwEbXh7sRtssSVvDSkS2opQZqoBevLB
	H2gGqYGF9DMBvGrp4p/MAuyjOki53JVQo+7ODVtsdZiLyfIAtZXbCSqzX8+7Ygg56Go55jzXsfd
	JBacX7zdtki36en4XbN1ewKAYkw==
X-Received: by 2002:a05:600c:a118:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48e51f35b3emr165636735e9.19.1778261634221; Fri, 08 May 2026
 10:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
 <20260424171438.2034741-1-yonghong.song@linux.dev> <DI8CQDATE33J.30U4FNOVZY97R@gmail.com>
 <7bfa2ead-3b2f-4ec3-be38-2146acc69eb2@linux.dev>
In-Reply-To: <7bfa2ead-3b2f-4ec3-be38-2146acc69eb2@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 May 2026 10:33:42 -0700
X-Gm-Features: AVHnY4KgOzQD0kHal2QcEi_ASvLkdgg2R3aUBYGAZCLhVWnQNJdZLhFbJbwNZEw
Message-ID: <CAADnVQJ4ygETq5HfOy552pWSUHtRiH_M103rzNRm6B8sR-biJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/18] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 2:55=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 5/2/26 6:03 PM, Alexei Starovoitov wrote:
> > On Fri Apr 24, 2026 at 10:14 AM PDT, Yonghong Song wrote:
> >> @@ -1669,6 +1669,8 @@ struct bpf_prog_aux {
> >>      u32 max_pkt_offset;
> >>      u32 max_tp_access;
> >>      u32 stack_depth;
> >> +    u16 incoming_stack_arg_depth;
> >> +    u16 stack_arg_depth; /* both incoming and max outgoing of stack a=
rguments */
> >>      u32 id;
> >>      u32 func_cnt; /* used by non-func prog as the number of func prog=
s */
> >>      u32 real_func_cnt; /* includes hidden progs, only used for JIT an=
d freeing progs */
> > ...
> >
> >> @@ -739,10 +759,13 @@ struct bpf_subprog_info {
> >>      bool keep_fastcall_stack: 1;
> >>      bool changes_pkt_data: 1;
> >>      bool might_sleep: 1;
> >> -    u8 arg_cnt:3;
> >> +    u8 arg_cnt:4;
> >>
> >>      enum priv_stack_mode priv_stack_mode;
> >> -    struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> >> +    struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
> >> +    u16 incoming_stack_arg_depth;
> >> +    u16 stack_arg_depth; /* incoming + max outgoing */
> >> +    u16 max_out_stack_arg_depth;
> >>   };
> > I asked before but if there was an answer it got lost in all emails.
> > So will ask again: why duplicate incoming_stack_arg_depth
> > and stack_arg_depth in two places? One should be enough.
>
> We can remove 'incoming_stack_arg_depth' in bpf_subprog_info since
> in bpf_subprog_info we have 'arg_cnt' field.
>
> I am not sure whether we can remove stack_arg_depth.
> stack_arg_depth is to accumulate the incoming + max_outgoing since
> the subprog may have multiple functions inside.
> At this verification point, we accumulate such infomation at bpf_subprog_=
info.
> At this point, we only have main program, so we cannot copy
> subprog info stack_arg_depth to subprog. The subprog allocations
> are in jit_subprogs(). Did I miss anything?

subprog_info is allocated early in add_subprog_and_kfunc().
No need to copy it into bpf_prog_aux.
JIT should be able to read it from subprog_info.
Recently JIT got refactored to see 'env'.
