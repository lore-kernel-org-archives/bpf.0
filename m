Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7022157B
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585442; cv=none; b=f5J/jsrepBJA//eTK1JS2OM/s81Et4oumI5S1Qzg8w8cCmLILonOQOGn9jt4aWCh5u1ETPDytTOJ15n/G82Rs/NZGWCloPaUYYKKpjvF1tCZJyZwfJkatRDpXhcbbBhw1B3C/nJRQup3xgyThwryFIZXp2a9kYgeJASLR+YaaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585442; c=relaxed/simple;
	bh=2N7N3DFQuE+aWAvgayOoeK9Kdsr9ItgNWqqp2QW4O6Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nsxANscWBVptVBpCeb4chJv5uM8Jbb9YkelX2mX02ksauJ8cOZLVvFJNUIZy5uIKyBzfNN8QRFNwfp8Fw4k5m96TzsMhPZ1QeSFW8GQjppAuoRPMiF5bP88zJ/wVQKMUDmHaxLLGwthn9LDcn20G987OXlDvHiaZ9QPvZWGJXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3IM3Kjg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4wj0Rt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3IM3Kjg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4wj0Rt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788585439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2N7N3DFQuE+aWAvgayOoeK9Kdsr9ItgNWqqp2QW4O6Q=;
	b=S3IM3KjgOrstj9VgPG83napvmCLC3q9XaVZqR0+tpQnAOk2XSMjtC/FvBbzVYal8cKwr+J
	m9xS+vGRMhon7IuSAJ1XqeZeZs368FvGS+kCUDyXbNFJYA6EcWQQV8ZcoRAg3DM6o2BwDK
	NhrjzKrpGFXTF8XqWCx8jdRji9PpbuQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-cQqJ5eArO8iKLA_lw1r2dw-1; Sat, 05 Sep 2026 01:17:16 -0400
X-MC-Unique: cQqJ5eArO8iKLA_lw1r2dw-1
X-Mimecast-MFC-AGG-ID: cQqJ5eArO8iKLA_lw1r2dw_1788585436
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482f2b8a116so1415318f8f.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 22:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788585435; x=1789190235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2N7N3DFQuE+aWAvgayOoeK9Kdsr9ItgNWqqp2QW4O6Q=;
        b=C4wj0Rt1aG8z10KRpscuBBY7iifGBYVVgRbirW9UaQbemI2JcV8gff8HvmATKuauka
         qOqWgnkN/ubcVhDL0iNq9QA1mbZf5TgmBOjEW6m7ZOz8mudoW4nWaJYkh3M5Kf9aBZSD
         db/I8Zz+M0I+pq1AD1oRnYPJWQDmej4X9FhZ2IXmbqJu3CYYJR5rmtowXe8zhwc7dC6U
         RKpIHTzIJ2j8efic0v9rHJPCWxVepXaMBbNgEDZUFdZM9uaGDM/FkpvCBrUjpYwfxiXD
         jwm6rKfH9OqkmA9CjeBKPbNc2GZLub4jqVZdxx2aC7+/mVCc8nFuAHkzSyUDtsScK+xY
         Tj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585435; x=1789190235;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2N7N3DFQuE+aWAvgayOoeK9Kdsr9ItgNWqqp2QW4O6Q=;
        b=GDYk9/DvmvhGXrZ2dTBu5zbIlpzBsQ3rs+jLQIjfGGzqGyXFeH+9CKM4FzLW0O5hFa
         12oxqvjjguXYkV8LuYxSY1rubSzdu1l/5Xkel5NmpwCs+GnS9ZDDr5v+fcNS97XUqleL
         v7YT3B7EE/GlWfDqmbSc3nXejiRxva1id+Qbmlhod9kpNWh9BXmP+YvZ7FZHlnLKAcUO
         qD5UT5/CgPmku9rJ1F4hp2FUyH++VsN9cshUPbZ46d0SQSTQ4Y9Uo4TFYAFhBTGxi4DP
         NJ29ZnSk4ywM/KiJxW0Y9E1irTu5lkSOdu6yJLOi5VszESL+pYKzeJ2ntTYL7h5MPyyv
         aFxQ==
X-Forwarded-Encrypted: i=1; AKwUvByv3LVLARqYpAm+Olde6OFYF+pJZknnXsTorKmqSAUKgJa/5H5mYh215Nu1F9HGv32gf7k=@vger.kernel.org
X-Gm-Message-State: AFuF++ma1UvsGi2XIWp7EhKj/NGzL5lGu8O/N+i6th0Y67OlHycOQuZJ
	3VrcanRi9S4YkCkZw3lNoAkwBKucFPLMy87xX/vxeiVsX27W64yTFdB4fe7kRawqDEFGO4qGFH/
	5L7nrY7iPSffVLZxy8RZN1WkefjZJa6pH48L0ZTJk+RC5mKdJqLC6ZQ==
X-Gm-Gg: AYBFou1EkrVNPpYe4Fhzto0hZ0I7yxYkCzPie9AnE5A6k1c6GMEhy9LqEpWKpq5RFjf
	z4Bhek4O8sTnzkGxeomLOpVaWNXXBSOxcsXufEYglR2AuhQ/V9LcRWHQYOLnJYIkvIyST2MfzqD
	iVJW67pVtUVoOVCiPhhRiJI4SL+pWZ8+LEQL/qSzS46rf122vzNiiUG2V9n6CVvg+uBHHmBEO3N
	IzTPr7SJ8ZAwB6YLc/8DtREg4jSBFe70WgTHUpWxbTYruU9rzVpvOhQjfX7EpxKgvr/CTTAMW+b
	a5hGAWxA+CiFYCmk3H0qGkX3zXL5fv/GNaHRAFZXTtSEptCLnOJzCQqZXTBsL/ufJyGBhrzhAui
	4rtimTuMWWQ==
X-Received: by 2002:a05:600c:4585:b0:49c:fc6c:be16 with SMTP id 5b1f17b1804b1-49cfea09f08mr58738555e9.28.1788585435717;
        Fri, 04 Sep 2026 22:17:15 -0700 (PDT)
X-Received: by 2002:a05:600c:4585:b0:49c:fc6c:be16 with SMTP id 5b1f17b1804b1-49cfea09f08mr58738395e9.28.1788585435425;
        Fri, 04 Sep 2026 22:17:15 -0700 (PDT)
Received: from ehlo.thunderbird.net ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm200070045e9.15.2026.09.04.22.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 22:17:15 -0700 (PDT)
Date: Sat, 05 Sep 2026 04:53:35 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
CC: Nam Cao <namcao@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
In-Reply-To: <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof> <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com> <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com> <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com> <20260903090211.50d15220@gandalf.local.home> <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com> <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com> <20260904123108.1fa1d815@gandalf.local.home> <20260904132421.111c0279@gandalf.local.home> <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com> <20260904194620.0c7a8363@gandalf.local.home> <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com> <20260904201741.2986efca@gandalf.local.home> <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
Message-ID: <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 5 settembre 2026 00:22:01 UTC, Alexei Starovoitov <alexei=2Estarovoitov=
@gmail=2Ecom> ha scritto:
>On Fri, Sep 4, 2026 at 5:16=E2=80=AFPM Steven Rostedt <rostedt@goodmis=2E=
org> wrote:
>>
>> On Fri, 4 Sep 2026 16:48:55 -0700
>> Alexei Starovoitov <alexei=2Estarovoitov@gmail=2Ecom> wrote:
>>
>> > On Fri, Sep 4, 2026 at 4:45=E2=80=AFPM Steven Rostedt <rostedt@goodmi=
s=2Eorg> wrote:
>> > >
>> > > On Fri, 04 Sep 2026 16:34:00 -0700
>> > > "Alexei Starovoitov" <alexei=2Estarovoitov@gmail=2Ecom> wrote:
>> > >
>> > > > bpf in 2022 was surely less capable then it is today=2E
>> > > > It took us 2 years of bpf core development to statisfy sched-ext =
demands
>> > > > and we're still adding new features for sched-ext needs=2E
>> > > > If you're trully willing to remove 90% of kernel/trace/rv/ and re=
factor
>> > > > it into tiny shim where all of the core pieces are bpf driven we =
can
>> > > > certainly work together (like we did with sched-ext) and add what=
ever
>> > > > is missing on bpf side=2E Then all existing monitors will become =
bpf programs=2E
>> > > > But adding bpf as another 'monitor', sorry but hard NO=2E
>> > > > If hardcoded monitors was a mistake then admit it and fix it by d=
eleting it,
>> > > > if it's not a mistake then keep adding hardcoded monitors=2E

Alexei, what I read from your opinion is: if you really want to do this RV=
 thing, then you should just implement it all in BPF=2E

Please correct me if I'm wrong, but I don't see how this series isn't a st=
ep towards it=2E I am obviously open to all sorts of criticism on /how/ I'm=
 doing it=2E
We are adding the possibility to write (existing or new) monitors in BPF, =
not adding another fat "bpf monitor"=2E

And if you believe my attempt to have in-kernel and BPF monitors coexist i=
s a waste of time, I get that too and I'm open to discuss=2E

As you mentioned, when the project started, BPF was just not ready=2E My i=
ntention with this series is to reassess this today=2E

RV was initially built with the functional safety use-case in mind=2E For =
various technical reasons this didn't take off, but that scenario drove tow=
ards implementing RV reactors like the panic() one=2E Something BPF just sh=
ouldn't do, as I get it=2E

The interoperability with other tools (via RV-generated tracepoints) was a=
lso a driving factor, together with Daniel probably being more proficient w=
ith those back then=2E

That's just from the top of my head: there are historical and technical re=
asons for why RV looks like it is today, whether those are valid or just "m=
istakes" is simply not for us to say=2E

I'd rather discuss on what is the best approach /today/=2E And that's prec=
isely why I submitted the talk for LPC=2E

Gabriele

