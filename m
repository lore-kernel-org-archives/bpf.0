Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574DE3A4F4F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056660; cv=none; b=Bl1HO9jrt9cTq9VcqfY5iRpBlibP5busDNalhXpWiBJHZ49WVtJVHdRHvmpzMh+ubSMNzdoB76iqZfnEJNJZh1iRShit0UCIA8ravnofT0V2tZgUNGeysVIUV8lolx7Gyj9Hh6o6+6mXKgigztkoULMstCzPt8Wjv00KbhWJRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056660; c=relaxed/simple;
	bh=bNDsGMnQx71dEQWIFI4yiXH735wX4TuPuBfM6VuqrfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dVjSzFRQfjOIYecJsynSSqMGCa+c7l10nlA/UEJagWPxtcRlW15W5oluK4sD3S7jwYbwj1o3aRvPrfl05ldEqmXVffbLR4RerpiNZJLRAAqHVeIZAtnqZwycPqwRK4pZXLN3zqfReM0Xnjhb5HWerlTSxTXcAm862ov2Tbq+AM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6DocFnV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lccRjXH3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6DocFnV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lccRjXH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773056656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3bg7TH0WlNH+XsmNxKjZXpIrTM8y8yXJ1xiD9A5bt0=;
	b=C6DocFnVjuqqSC7ptkxw6uHsprTrNdljvVi2zEBti0df/y2gT5iLimCBrq2er1ksk7JkyP
	MLezfCAgxiUGNmkTR6E+fhOAsJ8HT2/5tzkeU5kbvAQB5U/5lDv24uED4BuuzmpdMkoihT
	qihDvLT8djCxiHenLHMzm2QvwfMXNlI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-64yDFpOkP2yOdKB-b7JxVg-1; Mon, 09 Mar 2026 07:44:14 -0400
X-MC-Unique: 64yDFpOkP2yOdKB-b7JxVg-1
X-Mimecast-MFC-AGG-ID: 64yDFpOkP2yOdKB-b7JxVg_1773056653
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853ab1cae0so10215565e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773056653; x=1773661453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3bg7TH0WlNH+XsmNxKjZXpIrTM8y8yXJ1xiD9A5bt0=;
        b=lccRjXH3TV5q7d/Q5hMzIENBPUg8VxtaLppwRsgbnh2X/Z5Cd5qzErPPUgwdeybyeM
         /fiv34zanvlHj4mzgj6YmCjqX7e1QRt49UcmphTAxj2M+ayEO9XyE5Gv7Ql8S57VWOGq
         WtGEjnPmOzBMp/etNJjhiL3gzhu7CobzkQlQkxTyaEg4891c7VSOcGMR4f5fvnInqrtX
         qmu6bzapGersDfitENoPqf1AtOgPs/YCg0iea6pJTDNdt2FYKkRDNTMm+XSGEmYtzvJZ
         ahvRt2ygnibZnzbSWASyRULHgK9nCVR5lEJFL/kYxbgA6rR9tpifDQQM0HU3th6XgWQ3
         oRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056653; x=1773661453;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3bg7TH0WlNH+XsmNxKjZXpIrTM8y8yXJ1xiD9A5bt0=;
        b=SxO1/3TpzFs2XD2WVilpL224o6D+lHRdnPEmGo4xJSi/HyqgAePjFzXxfqVi2byKYr
         qOL1ZlMEG+6CPoT1r2rpbIdaEWuAvvgJAnf/lmkiFw7P48pho9eCoywPYAfRGwv1+NYX
         /uPDox7Unvxlzox+JBs3NsKxFv5MpogG6vd0B7vaveRE8yHhbjN+oknOPyOXmkJ33c88
         q9h1RduT08T4JPDU0LpPsbKqq5wrPHIg3ebC4u+hhrEauV8hWLdczQ/b/6IHocyIAI/g
         leuKalupJdViWStqlb0iPgdbCLuUDHHLb+aNeOPypnATHaMoHKG9tfAf3ng1spQMC2/5
         iSjA==
X-Forwarded-Encrypted: i=1; AJvYcCWN7p+HFb/sXabM2zX1XHGGJsSzUTZe/Vr+qtARFHYnOBeuOSESXDuOlbaJcPOJK39LzPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsgcL5L76rpWfTFucsmS3kdB5Cb9sboumFbx2qDvTyMZUL5lk
	VGkfTwCS3FqrubnzroYW6AQ5vnA4YJydrIdCeEazQuTxvt6Rov/qlyQLFr4rCedB+B03nsxnFkl
	esQzzhJ7biFXV4pmxG65wblD8Hsbk9KdR2cmLFRs45VwBU758nc7v2g==
X-Gm-Gg: ATEYQzyRKuOvI2I9xK5dGPY4+bY4ek5Qbai3FBYz25/gW0McngO/Qccg/y/zQP+EXMc
	lAE+eGRnBACdqQhSKC/sKXjPlh5cLzv13FUcxJeCgYqDwl2D3bHw2VoJImj+JcujycQxNiJpFTm
	uqGm4JD+6I/Ju99DUiqS7Gbr5oyONDT7irX2S4lihYPWF/hoFn2VocjxtSgr/S1pula7I/7nqYi
	xgNIPagcervOv/rzhFwk1NXKYgZosNvQOMR5IP9YZrsSseN6prmW9cIfsR3xuPMRD09MrviAhd1
	8zU4a734O700V3JFDfazX2rGbv9QuIWbogXtGMEbf3bYuT+HA3UyTiSpH/JH3GCkOGhWHv4V/+M
	F/Ru0zJzNmRAGElmwCzDpgEQCZPtWcCYBJFEUZeJZPK94shWB
X-Received: by 2002:a05:600c:8712:b0:485:2ce2:4c75 with SMTP id 5b1f17b1804b1-4852ce24f8cmr151212875e9.1.1773056652913;
        Mon, 09 Mar 2026 04:44:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8712:b0:485:2ce2:4c75 with SMTP id 5b1f17b1804b1-4852ce24f8cmr151212305e9.1.1773056652400;
        Mon, 09 Mar 2026 04:44:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485246ff886sm87283795e9.24.2026.03.09.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:44:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0A86F5A1D3A; Mon, 09 Mar 2026 12:44:10 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH v2 net-next] net/sched: do not reset queues in graft
 operations
In-Reply-To: <20260307163430.470644-1-edumazet@google.com>
References: <20260307163430.470644-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 09 Mar 2026 12:44:09 +0100
Message-ID: <87qzptp6ra.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Following typical script is extremely disruptive,
> because each graft operation calls dev_deactivate()
> which resets all the queues of the device.
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
> done
>
> One can add "ip link set dev $ETH down/up" to reduce the disruption time:
>
> QPARAM=3D"limit 100000 flow_limit 1000 buckets 4096"
> TXQS=3D64
> for ETH in eth1
> do
>  ip link set dev $ETH down
>  tc qd del dev $ETH root 2>/dev/null
>  tc qd add dev $ETH root handle 1: mq
>  for i in `seq 1 $TXQS`
>  do
>    slot=3D$( printf %x $(( i )) )
>    tc qd add dev $ETH parent 1:$slot fq $QPARAM
>  done
>  ip link set dev $ETH up
> done
>
> Or we can add a @reset_needed flag to dev_deactivate() and
> dev_deactivate_many().
>
> This flag is set to true at device dismantle or linkwatch_do_dev(),
> and to false for graft operations.
>
> In the future, we might only stop one queue instead of the whole
> device, ie call dev_deactivate_queue() instead of dev_deactivate().
>
> I think the problem (quadratic behavior) was added in commit
> 2fb541c862c9 ("net: sch_generic: aviod concurrent reset and enqueue op
> for lockless qdisc") but this does not look serious enough to deserve
> risky backports.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Yunsheng Lin <linyunsheng@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

