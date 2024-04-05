Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1F16D303
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322056; cv=none; b=TDkBMdSFfv0H3kEGKqSARLROJuIgNLpFk4p+CgnTYJ7MCuuBTOnZq8tEWxituELTIKTEjfWOuIWVWTTsD/G0Ye2XZpEX5x9/2hW7OXm+Q8MDg5kNZ57LsqRkw/cvWrp0KeZwV3gtk8oO6Po8rU25H/iPGg2OOhwB+z9rdxPswDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322056; c=relaxed/simple;
	bh=JimeStx1AxEiTnKcsJagFdmWpRaIN8O0L+53phs34Q4=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIzJpNW8E6A+wLVta7ytMAvVIcOvmqMMTYoP/OM7kIxkPz6LxenVHkW5d7tWpIO4XbJjTyA5A8C6EXCnHKnBZ8268sO7Wkg9Nmfd7602+5Jr2KqA2dUZXyxPRsUU+rrB1ao/8Nbo3NbSDfkFHT+kGqTMy60eT/kdl0mxz9H5Hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fmg4IQ2g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fmg4IQ2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712322053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxZUtQtjVGjRXF/qBbUdPZx5hjqkZReSzIfcUtT+LM8=;
	b=Fmg4IQ2gV88VM/AF/hF2BD0Zpuwh29gAwMso5WtqJ3EDHuS+X/Ug0mozgWVbZ8jrS1jYhe
	wTZyDXhVy3MxVdDvQVUA+p7VFTgDod3sjbg7N0kN62j556MQuZ4SMlCQC5KeVoO4LjaogB
	htSE3PB7jK9kp6SVx6wtLt+dtSUvPAs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-wYom5GOJNuOTeRp9HpZylw-1; Fri, 05 Apr 2024 09:00:50 -0400
X-MC-Unique: wYom5GOJNuOTeRp9HpZylw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56e1397b6d0so1262247a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 06:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712322049; x=1712926849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxZUtQtjVGjRXF/qBbUdPZx5hjqkZReSzIfcUtT+LM8=;
        b=BjT/1V1J0x0rHAGZ5nsfjtsn/w2WPO8osVPlkWBzA/Cy3Z/XSUAgpAu4n5ADKwLFE4
         9gyTz12vudf/O8oGWNy1x7EzGvKgxhn1n7a1pISip5i2vfJW2CqDr4APdtxsoGdI6bmG
         QE3RcpkOTnlgjOfPKkex8abhB2MTKFZWdwi7f115NK4vSHqaF8nOboAWPfVJilosinK4
         YjDIVxELOX9/NoIzhCvtSogPWqrbKPEAxBHelOKVC6QXiv2D44wiYwK/AMqDa+l5UIBn
         tsdv3JpY7stj6aDoWL+wPaJN5IC2eAmdz86//N8jSY/BbliqqviQsW2VuhZ63negrNAB
         G6ww==
X-Forwarded-Encrypted: i=1; AJvYcCWAjR+k4/jVyIu38mklx04rzZ1NICeRkyJKS5gopIsll7qhmqntIMlXcONwsFjNMqhxgVOOwWFR0L9Q+POGZOUK6lHC
X-Gm-Message-State: AOJu0Yzl5g7E6+CaGMFPrCnL8wSYP192qoR5gVybIbqOu2sjpBKlOhCp
	k+N3ofq+Jmcl68dU8yt8EdZTzJD5X5y76Tr/nyVslTRjx/y1s4SgDtuGHsdiSiYsnuDSMqLoA7b
	gTUxvmpqniP0gcx1ZUP3KEw3zSkNHlrV1TkRzHcgrkeEOUjnrOzc4+pXVn2zBME6gXB2uSgbYkE
	vKKk9ZHj1VWdTw/nw85AngWUir
X-Received: by 2002:a50:c34f:0:b0:56e:60d:9b16 with SMTP id q15-20020a50c34f000000b0056e060d9b16mr936739edb.6.1712322049304;
        Fri, 05 Apr 2024 06:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrcSHtZHcXL3adDj19d+7C6gNUs7CfvA+q8qubkrmEmxnJA3t0cmFqpbTdpIPTX/UI1obiDpAzCU1yJ4Fa/O8=
X-Received: by 2002:a50:c34f:0:b0:56e:60d:9b16 with SMTP id
 q15-20020a50c34f000000b0056e060d9b16mr936715edb.6.1712322048666; Fri, 05 Apr
 2024 06:00:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Apr 2024 06:00:47 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240404122338.372945-1-jhs@mojatatu.com> <CAM0EoMmp83pcVKuaDSL2UiD0xMZKtDTn_qod3GbPv3c1Qaf3hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMmp83pcVKuaDSL2UiD0xMZKtDTn_qod3GbPv3c1Qaf3hw@mail.gmail.com>
Date: Fri, 5 Apr 2024 06:00:47 -0700
Message-ID: <CALnP8Za0aTNLZzP9Vv0eeXz+eTb0RySyompDuNeCS71vbwAj_g@mail.gmail.com>
Subject: Re: [PATCH net-next v14 00/15] Introducing P4TC (series 1)
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	Vipin.Jain@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, dan.daly@intel.com, 
	andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 08:44:29AM -0400, Jamal Hadi Salim wrote:
> On Thu, Apr 4, 2024 at 8:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> >
> > This is the first patchset of two. In this patch we are submitting 15 w=
hich
> > cover the minimal viable P4 PNA architecture.
> > Please, if you want to discuss a slightly tangential subject like offlo=
ad
> > or even your politics then start another thread with a different subjec=
t
> > line.  The way you do it is to change the subject line to for example
> > "<Your New Subject here> (WAS: <original subject line here>)".
> >
> > In this cover letter i am restoring text i took out in V10 which stated
> > "our requirements".
> >
> > Martin, please look at patch 14 again. The bpf selftests for kfuncs is
> > sloted for series 2. Paolo, please take a look at 1, 3, 6 for the chang=
es
> > you suggested. Marcelo, because we made changes to patch 14, I have
> > removed your reviewed-by. Can you please take another look at that patc=
h?
>
> Sorry, Marcelo - you already reviewed and we restored your reviewed-by.

Aye.

Cheers,
Marcelo

