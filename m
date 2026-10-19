Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA73DCD85
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415131; cv=pass; b=ROEw8ePDu/vnTqOVuPIOjiTLA6EVbuWHRFIF/7aRVDbJazoAy5dlNGiN3309ZTzGg7qITaClpJuXgXWf+lxvMV/x1g9xaHXxlby3CpBpV6+pmnLWGdJUYDTiwzgm3vlYdmWNH5sZk3ncL50Z+fNyHwdXAW7tJgZ4v+55nqGMFE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415131; c=relaxed/simple;
	bh=PA8IT0mW8qyJLl9udMwhuGJy547uTDcbwByYbnkz5eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuJkBlc5P0B3swtMAsxBME71qlxnmTWlGpFSpqRvq+OeSzFDpoVkd5Lz9YXLD/3Dcs9D9qJEQUl3kfzV9Lu3MM0rMgrM9Gw3wYh4thlReKFlllYxQ3i32MZtezurj8UvBqWBuOaIp/SzHTPKyAf91em0WnXVrtf6Nya0uVYaJ6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMpfyA8K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQ+I/6uY; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMpfyA8K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQ+I/6uY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792415129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUPbdohuI5rYwK6fOugHmkfgJHBc1I0kpq40ADeEBNQ=;
	b=JMpfyA8KhiNKd4ujEIyXJMFkEGla0el34XzCnZuJXI9ZmCrYB0Q8RePm/bJId7Nme8wm2n
	Kg15iHahIz3zXgAORUy7vMX6hsel3q9PwNTQrQdqb5AlpifjnQAZ4Tx1DEIdepQ+vUxDr7
	3sfr3jOr4r0LXTnOgsB8F+XeWGuEehI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-PodJUwibNs2KtMnk63sYXg-1; Mon, 19 Oct 2026 13:05:28 +0000
X-MC-Unique: PodJUwibNs2KtMnk63sYXg-1
X-Mimecast-MFC-AGG-ID: PodJUwibNs2KtMnk63sYXg_1792415127
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c438ca31778so95495866b.2
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415127; cv=none;
        d=google.com; s=arc-20260327;
        b=YwFrE2BM5zCCGjB7bmPyriHxf+UaAqAcVBbfo9Yi9/WH7RW+ZZsneD9qSH7hl2ph3y
         kTeUt7ULo5X063o0VadAvR7iuppCwYgdh/01kLp2u4Kl9XMllPFm5f9PYiI6PLA5d9ul
         cc6qS2EKNrjPrMUwffY//0sus6T2ucVNFGdIabkTAQXWARbZ5dv3vHKB47SynX/6cHcP
         MBZQiDvG6cBSvfqTMshmCeQhiy8XT37kZlKiDrfqdTj33Xup1baozRDcXuMcVuwTjITz
         pQmN8147/MxMYDJ2VAePrUOh879g1ZREkdWuaVrUm0eAXRyiMvl/BUSEYymCnZYPoO6G
         pSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vUPbdohuI5rYwK6fOugHmkfgJHBc1I0kpq40ADeEBNQ=;
        fh=RWbsicjz9jvGasmeJitQc4Ux4Srhp0F6XdWGuqVfXT4=;
        b=XtGjepTOXJ8Uts2cf+b9V0JvzYH9y6W7LZUCjTdO3819lvaozD6cez3181BbYzZzVb
         sqKaYPl5KaZ1PVEcZMxoaSxQlY6Iy0hmiMao1GHSTbDQy+lgl4CsmP6jJAcv2JUUv9m4
         2J0k9KmOgyLdw9t5hPs7IUkChnHYVFEb8bdYD+pYSfw50gmJ4ByelwRM7dgogpR9dWz7
         yLrGKmBcr1iTMBSQOO1YZ+SWf6vp746g9wDhwkjVi9Tq4LdGXKdmOynvHV3dlPoVsVh/
         Y/smp60s9hta0gv4bxKe8Wdz074E/7Pt7M0SPTUBiCLKj2kK1TO1X1gTj3TWq2p1PMK6
         eZEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792415127; x=1793019927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vUPbdohuI5rYwK6fOugHmkfgJHBc1I0kpq40ADeEBNQ=;
        b=RQ+I/6uY/DZUnEmt6uREMIh5F12M3GW1INq4ZPX2351JuRIhvobmFPGJEruviL0Ui4
         FHHGb9HM0WxGh/KZpJWi5PfZz1fizNuV5o+XVvRbyNVex5Wsg3+G4qLWdJQGDdno/X4K
         BHgXa9JrjdgtrRA/H+66wKwIxSr2hboKTCkligE7w1wynmsB6q8b3ausmk381N7cUJjh
         NtmdDY06R3VmfZ9cR0y31pFeXc807r9kfX479mcP+JoyLttWjPiWRtFg1Hcoant5Dli5
         o0j3ZPOlRgc+bghlTcfisIL+gsusXdyHuIoB5MW9DRjk8V/DiixU29UtG/RPqZLknOff
         Gk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415127; x=1793019927;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUPbdohuI5rYwK6fOugHmkfgJHBc1I0kpq40ADeEBNQ=;
        b=1ZnztyCrkx+Ssz5mBFgJ/BImLhfE+NIOvXE/KwtP1CsXyZQDVbOfJq09SZGXGj+Zrk
         9eS2TqZ5WnubNNG0HVy0bYO9KLc2kTKdyqJfjPbVIpeh2GJznIvKCtcT3r2X1twyJvRC
         QeXQ4+T5e4aNHNlE3k9u7v0vcBr0sJZEnw0SDYDcLGqyUFTgvDLDsnqQ5uqcuaCf+WQp
         DAFhdKf1lf5RsmYuz9PkauPSr7n6ciz+numasQ4kad9hwLXGKFG6sYWRB41wc76ohsU0
         d6p6o/tEWKDOwrsg+Zd7i6B5tTznSlxw9gUjH5iaoinTUziZFakedUS/CEEChPj9jEqe
         0HYA==
X-Forwarded-Encrypted: i=1; AKwUvBwr0oPrOXG02rZ9h8L3KAOJEWrtOJu7U2F4DbDpydldwvy8Z507e1Ye1Scr7wzr+WrWc2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbAI3qvEmM2P1tLZg/ScVWn0wefdW7BsKgScxCcG2UEs7envUD
	sIBiA3SelpdqKFrn4dx3imYdz9NHZd7Blr0PGxoHreyxGmpv9KZznqsWap5GcPOLKnezDIFfTt9
	LhhNHNQv+yOhELKgGqxroufbgYju5KYIwoUM7pcqjojjJXadUfe8ga6vSEHrDA8oDRJB9H1Ic3Q
	PPRTgcEzkjv6ZIPDEeYEZHxzCE6gSn
X-Gm-Gg: AYBFou0SYDT7o5F+m0cUQIaWArjZdn/E/xzLVaQPxrNtaIhXtJ7/pbK8pwAN5vd+ub4
	Fs9uhBJ1DY7HNj9rymXTQLWYlKj6HhcCG6V3EYFX5vMaq7TNgON99kuaPKOn2OefRmcfdlFNzsw
	+ZjXEBS8q+JL7pntyMtNgYDrZwdQ06Bz/eknLm3Naric37ISj5hJHMMhySowIxmsloH7QVz6ptO
	wNwE1HbnjGcQXM=
X-Received: by 2002:a17:907:c008:b0:c40:f89f:d91d with SMTP id a640c23a62f3a-c419fafad52mr566086266b.28.1792415126882;
        Mon, 19 Oct 2026 06:05:26 -0700 (PDT)
X-Received: by 2002:a17:907:c008:b0:c40:f89f:d91d with SMTP id
 a640c23a62f3a-c419fafad52mr566081966b.28.1792415126452; Mon, 19 Oct 2026
 06:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com> <87ik2zryzo.fsf@jogness.linutronix.de>
 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
 <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
 <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com> <d2622f5c375ab26514d059b5949dee28f3f9998d.camel@redhat.com>
In-Reply-To: <d2622f5c375ab26514d059b5949dee28f3f9998d.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 Oct 2026 15:05:10 +0200
X-Gm-Features: AclHuK-qu9FGzZ1wQlrHPYBUAdZYSh4UcmqBXa3GV9mICyDiafDBWh4-NKWR3no
Message-ID: <CAP4=nvRhd1d+o8O045LB=dcYa2UudH7ZbG388wcwEX+JNBWY=Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:48=E2=80=AFPM Gabriele Monaco <gmonaco@redhat.com=
> wrote:
> >
> > Do I understand it correctly that the idea is to modify existing
> > tracefs instances when enabling an RV monitor to filter our RV-related
> > bpf_trace_printk events?
>
> Not quite. The initial issue is that the current iteration of RV BPF moni=
tor
> don't cooperate well with trace-cmd/perf. Alexei suggested we use bpf_pri=
ntk and
> filter out the desired events with plain ftrace glob filters (from trace-
> cmd/perf).
>
> I believe this would be usually equivalent to having a dedicated tracepoi=
nt for
> RV BPF monitors.
>
> E.g. you'd do (roughly):
>
>   trace-cmd -e bpf_prink --filter 'bpf_string ~ "rv: sleep: * violation"
>
> instead of (with a new kfunc)
>
>   trace-cmd -e rv:error_bpf --filter 'monitor =3D "sleep"'
>

I was talking about preventing other (non-RV) consumers of
bpf_trace_printk from seeing the RV prints. Eg. if I create a tracefs
instance and enable bpf_trace_printk, intending to see my own debug
prints, I will also see debug prints for RV, unless I explicitly
filter them out. I get that on the RV side, these are mostly
equivalent.

Tomas

