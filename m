Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674991;
	b=NlseLiFQyOKqtdbatPjv9VySDVik5Qcpmj6uTpYwRsJSCS3RgWsy6yITT2aW3mUMG2ry
	 M3P5GPe6KMggUsT/2abV+HnphHmpDMLrumWBk3/Rr8mmumg/biKYCRha7UwM/W70LnZXK
	 z5/55jwDCwwgJRc+yGTebSCls9HM7+cR5hTlcKBctgK3493BAL3yIzbqGijDFB9xaCoyR
	 P31vE81Pqo3fOfOO0pm4J74c5nDo+nsuHf+fr7hBq/MkaeLdhUmHnHdjnUbEYwRnT28ew
	 +mexPRBw7+ZxzHdrcMn4yWEr5MRv41VkEgXdqFNNuX7f21BK0l5GWsssYUJU0MFKKWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dIm7BgetdBymH26dv/zJcRvTygJQqs7GO+6HflsoA4U=;
	b=ns5MwCmeK1OGqOmJxr7LB4yO/AdesppIGGTmEJ0BD7dfhaEQCEnMD2M9Fmqwhp+28m5v
	 cNykJ40n2XtA/MbSOkhvQMNiNjTh680UaAS3Qc7ORiwdB6gfTIXWEhhZa0XsKxEgQUhyz
	 5+ww2aZ4iwOFUy0HPd5jSDdLy7PA1qvWZzNxoSmlmIvBEllVJOLd76PuuelfO5yQ7utJo
	 hLiSu77DtbYjtiSacHuElYO/Cn0a68NhQlasEmrRlM6e9OxLekh1OzK/2TdwZG6bDX1bH
	 VCZjg0lJf2dwOq5X3EvkhJg0FoAgJK5NUIfFToZfxQC2ssbKd3mYcUqTqCKCBo0kHKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=To4ZOhDA;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4B606D830
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 03:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6F4B606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=To4ZOhDA
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so1533811a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 19:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674985; x=1794279785; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dIm7BgetdBymH26dv/zJcRvTygJQqs7GO+6HflsoA4U=;
        b=To4ZOhDA7x492QcabmC8OMVUVMEgqW90desb9Fh/7TmwUxnsh2AC7KpqeVaJ40UKpU
         Rjqd+rjWUymn7Hab6mAJ/HIP17ubpbpmvILQamUZ1N3BdtF0taw/jdJpfCEUpGxW0H4t
         MGyfuywPRTASGKs6QBbfhfrijOqvyn88GBIrU3sijpUTTE4t5NcQh8lnJQQU/ViGxZFR
         a185B2efLhVvjAivY5zNl2KFSDOoeKMEEyRwpjujNk91KVwcpfVRO+6RWNj9n0xmYuH3
         ZLYymj/ntwgkHsQAEQ11vYJ99KKS+rrFfRFjE6G2FCpOlTkwKZQEvYJkmSUPRZ7jCCmn
         CvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674985; x=1794279785;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIm7BgetdBymH26dv/zJcRvTygJQqs7GO+6HflsoA4U=;
        b=K1qeelz8PKx29f/88ojjz6q3hGZH5994ZOBhlWsaAC8K/ygnjmeOnHyYjSlgRaRfVU
         EXPcAOrMp1rnxhXvsuNMpD9tTklz2vkxuEjTVlyutscHrFd32BGgFiQKIVhg2j0GxiH2
         NwO3DFy8b394aAp1skZH4KnWiKgj9FXUCyuxvXFd3GvkwDERc2KFN6HSxncF0M+SNQpL
         N/lH8na+1NGyocomNDbpPsyi9J7gHKP5DPpVc2Nt3FGBJLCe8jqY+4ePwb/zdjGs4sIz
         cHgfKu3qkUwbeqAJj78+u9OUCx9CFdgjRWtugDpcTnOI/68Eat5pbq5HiPfoSkZfDxsj
         9S1Q==
X-Gm-Message-State: APuU4Z/uPHIQg9xdA6MYGF+7xJbXmRi2RK0GhtN0AOUpD1aeG9cX6nqm
	RbTNxIEwVqe1J0mFaLudQ9N6lfZX36yYnMYJBN5pM+VNTH2YkFoNaGiV
X-Gm-Gg: AYBFou2bF9yLKAd1iGw/2j+8DzBsOnEnfSHXaWOrSJd6fINlOdAzWC9q6jIRi4xJL+d
	HL6giRNta1yIkcH73TkAq4l2rCOSITcM5JWZxKgiswrhNl/pg8U8HdOZDfrCfTQEbfjJDXSVhp2
	A/y2VOeCHCyXGGBTlic+IqqLKrga0VyKU8Umas9QnOt8uikNhu6DfpS244XcwU7zA64QfGNLPy6
	hcMhs7rlLUYGJ67A4AzkS9vlvyJlhYZjCiKjar21cwCbYani+zwwBh+Im+OMnyOhhUfe7+YOQqD
	hSBWOPjoc0uGlOUIuydx3Lvf8FPZJI4lIRI496Ex1V/FPEzymXYevzMfg0wkcbJ82uUShGDrpHx
	/uaqj8W0OnCkMg0n0ao+/cUk0Mse1/2IEvFcVoc6Jd1vNGHR14xAVLTnDGmbuUbYBOeBRSCEMfH
	Ef8xppmjWaAjMZU3e6PSeRlhRg811y6+4wyfgyWEfZZLP0sG0jDrQ+ugnRh1q1ekSYqNG0K54CG
	TgehZYcy2GAyDXkbfHm5C0Nn7Z8vysT2IFR6JHlr6WY2iDqJBsiOQe/F2LhvSk5dWUEMVG81GhX
	s6gQpg6GpCA97iuyrWluQzbs8Z3VjFBCe0phUFEC4OgMEaNKhSQr6um2PGFaSxUggjtZP/uf5Rg
	+HihrHdVSt16FHOPIyECIQ7aEuWqAx21/qNMsTs+hPV1Gl6c4BWyoiK0=
X-Received: by 2002:a17:90b:2751:b0:3a4:b3ac:904c with SMTP id 98e67ed59e1d1-3ae8984ec60mr9411922a91.51.1793674985074;
        Mon, 02 Nov 2026 19:03:05 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb36468bfesm514332a12.11.2026.11.02.19.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 19:03:03 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 03:03:02 +0000
Message-Id: <DML8PRKSQ4ZX.2A8Q5SC26RO6Q@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix suspicious RCU usage for sleepable
 bpf_get_stack()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Feng Yang" <yangfeng59949@163.com>, <song@kernel.org>,
 <jolsa@kernel.org>, <ihor.solodrai@linux.dev>, <kpsingh@kernel.org>,
 <matt@bobrowski.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <emil@etsalapatis.com>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>
In-Reply-To: <20261102073714.1103088-1-yangfeng59949@163.com>
References: <20261102073714.1103088-1-yangfeng59949@163.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 11:37 PM Feng Yang <yangfeng59949@163.com> wrote:
> Route these paths to bpf_get_stack_sleepable() and mark the new protos
> might_sleep, since build_id_parse() may fault in file data for
> BPF_F_USER_STACK | BPF_F_USER_BUILD_ID.  Sleepable programs that call
> bpf_get_stack() from inside a bpf_rcu_read_lock() region are now rejected
> by the verifier, which is the correct behavior for a helper that can
> sleep.

That's a new feature. It's not a fix for the splat.
Andrii's point in v1 is about build IDs. That's a good reason for this
patch, but the splat needs Songsen's patch anyway:
https://lore.kernel.org/bpf/20261028121859.994-1-yangsongsen@insta360.com/

                                        Songsen's patch  this patch
  ------------------------------------  ---------------  -------------
  splat in sleepable progs              fixed            fixed
  splat in bpf_wq, task_work callbacks  fixed            still there
  build ID when the page is paged out   no               yes
  progs that load today                 all load         some rejected

Row 2: the callback is sleepable, but its prog is not.

  bpf_wq_work()                    rcu_read_lock_trace() only
    callback_fn()                  prog->sleepable == false
      bpf_get_task_stack()         may_fault == false
        __bpf_get_stack()          no rcu_read_lock()
          get_callchain_entry()    rcu_dereference(): splat

Row 4: sleepable fentry, lsm, iter, syscall and tracepoint progs that
call bpf_get_stack() under bpf_rcu_read_lock() or bpf_preempt_disable()
load fine today. With this patch the verifier rejects them.
It does so even when flags don't have BPF_F_USER_BUILD_ID.

Pls respin it as a feature, with a new subject and commit log
and a selftest.

pw-bot: cr
