Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1325C90F
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571959; cv=none; b=BQkE+AFphOkoayC2LchX6nJT61HcujC/dt5dLSO6Qp+iNpq6Jhm1wtMDVS90HE3zMM5N0aPWbRSf/Zb057zIdS3kIk/wQw6Vvc5dws7FzA7PwR6ZSkXyxW5T2429hQ8afPZYvau/wzMeHabXpwkH3eNCS6euDHOTdLaKY7cqXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571959; c=relaxed/simple;
	bh=hfgK2jsXaSmu8armMhIlRT4YTtPLzimTCj2DMRRN4Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:Cc:
	 Subject:Content-Type; b=hhCUl4+SH1Io2+K868xgxkrsfQ2ve1X2/vzcrYD6qBziu1/b5t5iGgMqRFv9SnPqQuFA2HibXGkzjAw+zA7R0ZBDmCWQbSxTN3vYQoWbvuD1XgD8+uQv0B3oiFvTDv0/legJhNyeURr3zHst5xraifK1QejFZUgstrhIQmSjQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=zb2pqW8b; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=zb2pqW8b; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9kmLSj1 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="zb2pqW8b";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="zb2pqW8b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9kmLSj1"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 44338C180B5F
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709571957; bh=hfgK2jsXaSmu8armMhIlRT4YTtPLzimTCj2DMRRN4Ww=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=zb2pqW8bnFEqya1EAh2xi1oQmx7IXqwzFl+5gluPFNxYNeQxt6/8jRYDKw6d6YZo2
	 MW4A7Cb/jDhfSA/3MWPchnadKRSb5Km55OGzojldfYiyyozMuBGb3DJ3/0vqEnqwuD
	 ZUtLsnAUsDwBXyZy2KuzMe0APMFUjy8svYO1a8Ns=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Mar  4 09:05:57 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 1DB3CC169506;
	Mon,  4 Mar 2024 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1709571957; bh=hfgK2jsXaSmu8armMhIlRT4YTtPLzimTCj2DMRRN4Ww=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=zb2pqW8bnFEqya1EAh2xi1oQmx7IXqwzFl+5gluPFNxYNeQxt6/8jRYDKw6d6YZo2
	 MW4A7Cb/jDhfSA/3MWPchnadKRSb5Km55OGzojldfYiyyozMuBGb3DJ3/0vqEnqwuD
	 ZUtLsnAUsDwBXyZy2KuzMe0APMFUjy8svYO1a8Ns=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id BE013C169506
 for <bpf@ietfa.amsl.com>; Mon,  4 Mar 2024 09:05:55 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -2.108
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9zLKUq0cqs2x for <bpf@ietfa.amsl.com>;
 Mon,  4 Mar 2024 09:05:55 -0800 (PST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6972BC14CE2E
 for <bpf@ietf.org>; Mon,  4 Mar 2024 09:05:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d146737e6so3564935f8f.0
 for <bpf@ietf.org>; Mon, 04 Mar 2024 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709571953; x=1710176753; darn=ietf.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKDJoniJlb1Y7Lve6HZtXVf9kI3aIcrvEdXe1UbGU2A=;
 b=l9kmLSj1qKHLvEV0oY3ShiWjEMk3BfpGJX1hRH9ovvkvZI4r0Pg2pYlyeyLESWBXB7
 02eP4v+145Oqa4BhmcOVlv8IbZBdr24yOugl3ECr4PwvuYZjGPCSpQB3442zgjmAe8vS
 97Wg6vBlGM5JvuSDzp/qVDM5imBPTdkOzBl6Uy1uo/wAUYckLw4IqQzQMrzjpzIdwr6K
 Ip+57OnBZCqP/jIVGizIIuuRhsCamYKHgOVa/Z6ACFpp8ChFI0n68MxePpSriRThuG91
 8GqcFo1I+9oNDYtLetjgCYTs4FYnrTKxhYPyLxpV3WVNfPf1zYoix68MlE9c1sNBo4Os
 8lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709571953; x=1710176753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKDJoniJlb1Y7Lve6HZtXVf9kI3aIcrvEdXe1UbGU2A=;
 b=nj4RP5o3nNRHHVzq98P8n65c926aI0LSms2V6nXsNBCyDFOwM3pnRV4hGxnu99y0EK
 mMCpwAau/quQvMFcYJx/aKAq1SCkONR6Vh9JzK2wMb0pXLW1KWZQ04jAMjpAw71zmwm2
 EKyejiA5L5hihXaOgzvoZcO9k/NawaQAZrV/sV0NsVAEk7xnCjHRtHj5lnDoSRftYbOQ
 vkNsZZ0XNr24tCArbtBzEfD4w3R5TpCP3/YlbEf7Uyr/MQUep+cifAUCTIQFAEliDaTz
 5ufRjfnrpJ0ZrKzLcpoViWRB1HLlwL1o4WhaBTVQ07sguFfq3+aGewzzXTS+JhTezwnp
 806g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpJBkdo+WdElQuePYtwrn3zAcrcideAeNi9QsaQx1D/VnATYFL8uRy+Jn7AhD4XCSqTA9iiDAZFJH4M7A=
X-Gm-Message-State: AOJu0YzkGGb9LYOs/civVql2r+Zo02MAeTKr/+8qhc8O3WupkvKEKmGo
 r+Y7ajCyX8mnHNB2HVeRnPLrHbmR4exu36TnI7EgKFKQCAVDZ00OWDV88amFByAsBD2HyWAJo9T
 dvxIBzJRM1PHxfxJr+EnQ3P+g2wE=
X-Google-Smtp-Source: AGHT+IFFOxBqElwbetEw959W3ih4kYDuvgJeG0m1www75tlV9V5vSA4MGElmyZ0pFpXKdrae+ANZz6LJivR0I5JWah8=
X-Received: by 2002:adf:9c8b:0:b0:33d:47d6:c159 with SMTP id
 d11-20020adf9c8b000000b0033d47d6c159mr6804323wre.12.1709571953320; Mon, 04
 Mar 2024 09:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
 <270f01da6e53$63e93620$2bbba260$@gmail.com>
In-Reply-To: <270f01da6e53$63e93620$2bbba260$@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Mar 2024 09:05:42 -0800
Message-ID: <CAADnVQJRzLTs6mDTSofCgCxoR8jv8C30g_hHJREM8+fQpXe_Xw@mail.gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, Kernel Team <kernel-team@fb.com>,
 bpf@ietf.org
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/tOK4mznO9SLhHkUSWJsiF-4WuAI>
Subject: Re: [Bpf] [PATCH v4 bpf-next 0/4] bpf: Introduce may_goto and
 cond_break
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
Message-ID: <20240304170542.v1caiQHOlEHEuf27gip5-UZRyG4fyIAPJaXzL5Sacgo@z>

T24gTW9uLCBNYXIgNCwgMjAyNCBhdCA4OjQ14oCvQU0gPGR0aGFsZXIxOTY4QGdvb2dsZW1haWwu
Y29tPiB3cm90ZToKPgo+IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdt
YWlsLmNvbT4gd3JpdGVzOgo+IFsuLi5dCj4gPiBBbGV4ZWkgU3Rhcm92b2l0b3YgKDQpOgo+ID4g
ICBicGY6IEludHJvZHVjZSBtYXlfZ290byBpbnN0cnVjdGlvbgo+ID4gICBicGY6IFJlY29nbml6
ZSB0aGF0IHR3byByZWdpc3RlcnMgYXJlIHNhZmUgd2hlbiB0aGVpciByYW5nZXMgbWF0Y2gKPiA+
ICAgYnBmOiBBZGQgY29uZF9icmVhayBtYWNybwo+ID4gICBzZWxmdGVzdHMvYnBmOiBUZXN0IG1h
eV9nb3RvCj4gPgo+ID4gIGluY2x1ZGUvbGludXgvYnBmX3ZlcmlmaWVyLmggICAgICAgICAgICAg
ICAgICB8ICAgMiArCj4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oICAgICAgICAgICAgICAg
ICAgICAgIHwgICAxICsKPiA+ICBrZXJuZWwvYnBmL2NvcmUuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKwo+ID4gIGtlcm5lbC9icGYvZGlzYXNtLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMyArCj4gPiAga2VybmVsL2JwZi92ZXJpZmllci5jICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMjgwICsrKysrKysrKysrKystLS0tLQo+ID4gIHRvb2xzL2luY2x1ZGUv
dWFwaS9saW51eC9icGYuaCAgICAgICAgICAgICAgICB8ICAgMSArCj4gPiAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL0RFTllMSVNULnMzOTB4ICAgIHwgICAxICsKPiA+ICAuLi4vdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL2JwZl9leHBlcmltZW50YWwuaCAgfCAgMTIgKwo+ID4gLi4uL2JwZi9w
cm9ncy92ZXJpZmllcl9pdGVyYXRpbmdfY2FsbGJhY2tzLmMgIHwgMTAzICsrKysrKy0KPiA+ICA5
IGZpbGVzIGNoYW5nZWQsIDMzMCBpbnNlcnRpb25zKCspLCA3NCBkZWxldGlvbnMoLSkKPgo+IERv
bid0IHdlIGFsc28gbmVlZCB0byBhZGQgbWF5X2dvdG8gdG8gaW5zdHJ1Y3Rpb24tc2V0LnJzdD8K
CklmIGl0IHdhcyBhIHJlYWwgaW5zbiBpdCB3b3VsZCBiZSB0b28gZWFybHkgdG8gdXBkYXRlIHRo
ZSBzdGFuZGFyZCwKc2luY2UgaXQncyBub3QgaW4gYW55IGtlcm5lbCByZWxlYXNlIHlldC4KCkJ1
dCBtb3JlIGltcG9ydGFudGx5IGl0J3MgYSBwc2V1ZG8gaW5zbi4gQ1BVcy9KSVRzIHdvbid0IHNl
ZSBpdC4KSSB0aGluayB3ZSBuZWVkIGEgZGlmZmVyZW50IGRvY3VtZW50IGZvciBzdWNoIHBzZXVk
byBpbnN0cnVjdGlvbnMuClNhbWUgdGhpbmcgZm9yIHVwY29taW5nIG5vcF9vcl9nb3RvIHBzZXVk
byBpbnNuLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3JnCmh0dHBzOi8vd3d3Lmll
dGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==
