Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B304B4058
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403188; cv=pass; b=bzKc+xgLaA92siurAHw34ETOHS5bQ3xVSS6qQSYy34ahQ+oR3Gh5QlF0UBjQPC3kCWWkZLKLj4I4uGPobj+KtzIaODvJUaIMhbi8XVteIMEEQdTu52+a+PPykCtbESehbq3ySdiKEy56RbqK2AUwYNayPMxqq14rMOBuRi2fgGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403188; c=relaxed/simple;
	bh=SmLex32CfN0i1QL4gh5elS6PvTSOZDSeNkGgujocXKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sjqtu/O4RDbLhi5DVWr0bBGIIlvd2v1aHhzpZHOG0QiouklB69bn/9vBoeSoQzGGaeoOdjDVS0X/iDRN8OBT0znyQiFNhB6IGeWLXwVCUG4NvwXcXlwLZ3g7U1fOXZwO6x9d933heUrrMrtvjXUqesA6qeFbwWgYx/Gd1Z0irpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcTWPhus; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1ARUBtL; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcTWPhus";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1ARUBtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792403186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmLex32CfN0i1QL4gh5elS6PvTSOZDSeNkGgujocXKw=;
	b=AcTWPhus6Bmr2mdwl7BLw4Xd3s4ZUI4nOf+W74LcsBEEZrwFnucJePgIvJFqTqvxQhg8b+
	uTSZ7JCEqI34Cj26mwY831wNMmO/Oa4s1F7M1PitxlNUOzTB5HBS12rDL+Aui1gvV5b00U
	/nUny8pWFDGZ0ZSipWt4rXWCTQyWhw4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-qEljfMahNP6ct1H1DscJBw-1; Mon, 19 Oct 2026 09:46:25 +0000
X-MC-Unique: qEljfMahNP6ct1H1DscJBw-1
X-Mimecast-MFC-AGG-ID: qEljfMahNP6ct1H1DscJBw_1792403184
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c37b2763f1bso170221566b.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792403184; cv=none;
        d=google.com; s=arc-20260327;
        b=n74QUdC9SX7EFKwK+i80i540Stlx8owlrzq2FjnU1rbZu5bf9IYz0k2LFhbzBWQ26L
         V5nQz4uGeafMyJxyee64mLBJ5rEgGbbh/HEozDIltNuReGE3S4Q4/gE7yt+5CWGxwtqR
         eZ8i3jcawmM7TXENCG7dqsAU4nh0zjK4YOlRKWzu1GYlelK6Zs/VwX45yGCXG46B9ptk
         ZuU8c3Bb1q5hoaPtPe9sbAb74DzZGk3Yp0FN4vaRdeRKEOoiIn34EezKAxEJBcF5ChNt
         dbuRooASCIOOZQy9qnWBfxV7dXP9u2iLsI1olKPIk8cfweeQuWaf0yl0N+Xw+tR4WsFr
         MqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SmLex32CfN0i1QL4gh5elS6PvTSOZDSeNkGgujocXKw=;
        fh=bpzFmdMXm68BSxNMe8B2iEVkNDEejQIm1SnB7LdqUhE=;
        b=aPJQ2lD806vlazglVhaXe218IvtdOmkMD/R1TD73qdnGL3zGfePIcxHI3ove9m82Sf
         BsZj1QsBzfCXivcpUR5JySXuiJ6l2BDQJkh14Y6nvpuQQABcZTi8V7h8+spqQ3hOeBOl
         AlFcLFFkHjgbqqO/aCOfCFasyRXFIlS2Kj3dVrpDBZi+NSpkOCxqqCEzlDnsR72t7Fsk
         VZZ5zXVAteh82DbrRW2WcukL7NX34vlqPYSPsybZNVqj/bCtHts3BSTBCWVftFq33e2G
         UIm99np7SAHWqlTRg25hE/lxBhscDlThPKfBWzeGIkhl0uJLz8RaLQaAOwX619u4dW6Q
         2/ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792403184; x=1793007984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SmLex32CfN0i1QL4gh5elS6PvTSOZDSeNkGgujocXKw=;
        b=V1ARUBtL96GNFwCUUT9Lx3zGqMkQOLF3X5NbQgHRqyLhYNrW2WyPNNDGtw4YVZqU+U
         SYyjRU24Eqn/I07vJvLcOzGTTBqswZann2YtUiVUOWzjr9Qtk5aD6Qv24d/q1K1Mp93z
         7ClKbp5aKvlQlZq0t3a8b2sODA4K//+ILo9dRxTFyalfUAaYZ1xOjAde4jFlkpK/9u7P
         ROpUehn5z+tPQbJ8gWv04BS/MCqjj39vxscMgvlYYkHbJj4fPfeE6DLiaH00gLKhTI6I
         Kf4ovFHG8Id9UvXcmVmul4LjtOtBZ/0yDkFD2vH6yf3yxg0dmlk3H1ZN78TLvB2obJV9
         VPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403184; x=1793007984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmLex32CfN0i1QL4gh5elS6PvTSOZDSeNkGgujocXKw=;
        b=BiQWV2B/V4VEzvAxW/0gLBE6oFFFqgzhy80GV6aFWSJwDrbbMIAkXgy/+DwJFaGg5l
         GZPLLoqCaQ+jMyoEt9AyERgSdtwiD+9jFMaNhB9Bv6J11EHt0t3jJ09PBTtj9xhom5xa
         t7tFHB4aF6FWzj6mI//EMsA6kPV0eYRyR+9/4Nw4Tnc0G+3A+wnzyqDi5c7odnPWrz7a
         zFbWJVMeq2k9NsIMn4NtpZXx6qjYkn8Nj+kPPvvqyp5lCxsWstnAQiw5tDaoMlxTs3g5
         9UiTSD7aXKoiIIRttMOuHnCjsRbggVDngBlUAYhDoA1m5dLqO6qTGDJfq+AGP1CmRliq
         2NuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwb4/T5ytc4s9yD6fwxxu2SpibHeqASql7ERiIWcbFKW0+f35LPi9pAt+hMk5yZFTcZHK8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8xjndXP1M3RfoqUzwUhXAz5F+xG4wNufAS6+9fvym7ETUUCQm
	WXAbqF9DO05D/12Co6v/orkqicDy9mSCG5avBAHBdOO/QaGcPGjSf7t2Y6eHj93Sgly9kQX3LUc
	aCHvXBbxCtG4KL685Elpd3iph8SBJqxnQjv4222x8eNjTee/ZpIkDsGN8o3DvUjg6sgRMTu5Aqs
	qN6xoBQIDMjnDJxdtbr6AZh2zdwKDE
X-Gm-Gg: AYBFou106Qx8EBee9iOAdi3gTFCmoHxHgMBPgMd9jAspenmYwwcwWxYgw9dTO0NzwKD
	G0o8Ss13UHcLf07YDvdUyKe5XdQNNiRqFUCjEm/Tx8XZNrug2CRZZkPUUAngxQxwh7OsL6Dh4vx
	iyvGo/5sONcx7VIB42dFzRMhErEN5RM1XAUXqz1qop4rrTQo0QoKfyHG7HHNyg+41Ot+7WSZMBM
	QpzR1BhgLLsyfk=
X-Received: by 2002:a17:907:9725:b0:c41:8e21:4d58 with SMTP id a640c23a62f3a-c419a256eb9mr501680166b.5.1792403183858;
        Mon, 19 Oct 2026 02:46:23 -0700 (PDT)
X-Received: by 2002:a17:907:9725:b0:c41:8e21:4d58 with SMTP id
 a640c23a62f3a-c419a256eb9mr501677766b.5.1792403183439; Mon, 19 Oct 2026
 02:46:23 -0700 (PDT)
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
 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com> <87y0buox9f.fsf@jogness.linutronix.de>
In-Reply-To: <87y0buox9f.fsf@jogness.linutronix.de>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 Oct 2026 11:46:12 +0200
X-Gm-Features: AclHuK_NXeaiajImg7lC8SzWuELhdtiOXhAgcdN_7Skq7dYerLf6JAXl0TbAm20
Message-ID: <CAP4=nvRXYieOtqLuE6SypkKHf1gtEjUbegb=wYiLtmAM9SHuYg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
To: John Ogness <john.ogness@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:34=E2=80=AFAM John Ogness <john.ogness@linutroni=
x.de> wrote:
>
> For production environments, I expect that trace_printk's are only
> occurring for violations, in which case the cost of a string compare
> will probably be irrelevant.
>
> Are these trace_printk's available without getting the scary kernel
> warning when kernel code uses trace_printk()? We do want RV support to
> be enabled in production kernels.
>
> John
>

Since commit ac5a72ea5c89 ("bpf: Use dedicated bpf_trace_printk event
instead of trace_printk()"), bpf_trace_printk() does not use
trace_printk(). Rather, it is recorded as a separate ftrace event that
has to be enabled, in
/sys/kernel/tracing/events/bpf_trace/bpf_trace_printk, for each
instance that wants to trace it, and using it does not print any
warnings into dmesg.

The BPF documentation says otherwise [1]:

"bpf_trace_printk() is slow, and should only be used for debugging
purposes. For this reason, a notice block (spanning several lines) is
printed to kernel logs and states that the helper should not be used
"for production use" the first time this helper is used (or more
precisely, when trace_printk() buffers are allocated). For passing
values to user space, perf events should be preferred."

[1] https://docs.ebpf.io/linux/helper-function/bpf_trace_printk/

but that is clearly outdated.

Tomas

