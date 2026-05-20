Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F733403FD
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=166.84.6.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293288; cv=fail; b=odi3EPFKBIszKvAFP1quuESO0rVZMwhXISnTJNMAuuoGr+M4VSUWwcDZ6oqAMsLnEy/E5U89UhtzZhKjJeCFwqXQ9+1qRbuRlIoFqSgvzhkZmChH6BSCEtHN7orf0BmUY8yDxADNp99jOQgdRpcMVHy2p41eNqDpRsWugPxyG/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293288; c=relaxed/simple;
	bh=NzaWAi30Qa9BJRFW6YMAQ0YH/QcDLFaPDFPO6YVHcgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=un6HFKz2tvyH1d+MLwmrXwT+Pkc4ySy5oqM7js6FIGj0X8FaovwgMJdzsgOIOsGqjeapUZoKYnfJfmM/lQPm/phmmTgQZkiaAuvyRr/dWVUr5/fifRMgk1J5UF+OFG3jH+M222j1wgdjH4S9RYbAabuxrlXNjrp8g4cLZ9GxGXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=IHbjymPE; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=QwFS/I72 reason="signature verification failed"; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1xzO44W reason="signature verification failed"; arc=fail smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="IHbjymPE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="QwFS/I72";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1xzO44W"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id AE0CCF1AFE05
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1779293285; bh=NzaWAi30Qa9BJRFW6YMAQ0YH/QcDLFaPDFPO6YVHcgU=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=IHbjymPELFuQCd5K+JVksgWeUl7QgKJExbjmE6AGfJ4sTbL3kE7uz5/REbW5TwzKH
	 jvXgI59dYavNg6dKuAV3d85AJf/6zRlAGz/deh61et/UGSCG7NUMag5bPm/BBVfmSd
	 9afUuep6Mrs80enG6HIuv2Zmtgvq2JiqX+CX7lqc=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Wed May 20 09:08:05 2026
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id A68A2F1AFE04
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:08:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 84EC1F1AFCF5
	for <bpf@mail2.ietf.org>; Wed, 20 May 2026 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1779293280; bh=CvXC4Kyo+V9VxvlqU7vlE27Z0xiXsRLyPCMwJRtE6jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QwFS/I72FHlx60d+QQinbuxVMssBVwkubHJ4pvpl1dbrH3cU5J6EKRErIihkMw1iK
	 5j3gANjW7VVV3s11w8n/FmN8RkoH+hv/wmsfuCFTNXT5KVx1+HHzBVWvoMkni4N4i/
	 3Yu3jr+j7gOTejWMiQLQCjkjJzDmY3DTCBxiX1I4=
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -1.099
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail2.ietf.org ([166.84.6.31])
	by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gm3PxFIktID for <bpf@mail2.ietf.org>;
	Wed, 20 May 2026 09:08:00 -0700 (PDT)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail2.ietf.org (Postfix) with ESMTPS id 18CEDF1AFCF2
	for <bpf@ietf.org>; Wed, 20 May 2026 09:08:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso2725666f8f.0
        for <bpf@ietf.org>; Wed, 20 May 2026 09:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779293273; cv=none;
        d=google.com; s=arc-20240605;
        b=hXpdzrRRbzyPiHj+fGxH6XtFKQ8kmYrXBFZhAtGLW/0t/fcVUF4a/Ay1oATjcP4sPq
         jOY6BSgXCvpXIfk9xjN2YY0gidOXvf1j4Z+GryMgmXinelZ7avgjM+jaEPxsnjzgcjM8
         lE22xmIWm8SgC7W+m+UxJGztoJSNZgwwj89cdf2pMWgGmHMkBzl8QqaRAfl2Naqyf8K8
         +20OYgu7Xui5vHR0gjo7/w7ODIbZqd4nXaP4b6kCuK3xu3Dq3Z/6ADN6wKW85IVVcXZu
         b2RFUQp8MtCsGq3j4In1RIUchyPsiHRmhDnYqRHHUB1wBFWyeex7IbKnrWS+fpx6Eu+Y
         wMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1AueEqgTUy6nsRVxmiTY07dthKJdLYGxsiOoVyUMH18=;
        fh=kvizrhO2oG3f6AFAfzUe5bQS6MQ9M3aksnmdLvQAZ60=;
        b=CUGfTLVUhUyhTJRO9QQ8AzfgtQf4F34gI5cfy+16blzg+V6J2KOGiqkc33MY9JzzbF
         9UItA4CULYOWZztYuwxwa2GLBh/GF8XbL2qW43vQ+KCpG7kP5au/CbnYDZGY2rqe+C7E
         5cjlJ3pCuBzX+B5ifGgRh46oBjkaeHjNlIW/UGql6f1XoF6Beml4QIYfU7zmdz1u2GIx
         lKlIgDSGRAQnyM3dE+6d/vY8mpq8v26nxSE4JnqMDpTgGo62//K3DELBUk3xtX50Vdqi
         d0HvRI9YMyzVCK9/qFjJrbfRLi41YhoQmbZoK2He0jIdiTAX0QpEowwq7hihl/Oob47p
         bkQQ==;
        darn=ietf.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779293273; x=1779898073; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AueEqgTUy6nsRVxmiTY07dthKJdLYGxsiOoVyUMH18=;
        b=c1xzO44WdArnL9lPmF1YB63GoQ0x33JLhBul0rdf1bTApSSV6RyxNvBPmahiXvWy0h
         hSADT2qpO7pwuyH+3OE5/jTlLmCjqSjsHIHGyRxALsJO7jPCk7PpqXcZJzqZ6dTIRP3N
         AvX+iqED7KNz47Kw4oAptakJ9V2+P//7bjxYnbhe1dtaIictWUkdh4UqA2YCWDOsj+cF
         BZ1HVmt1Wv9Xxf/pwOa6w3vEmVdqDu77XNmpncTc/J7hq6FN64tAGDp5/I0+JIJ3egF1
         oDJL67m7H3zYwmJVLHmG18js5sVtl6X1YOMBRbPssGI/qJWArEovXVQUkKp0+KpwJbF+
         gNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293273; x=1779898073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1AueEqgTUy6nsRVxmiTY07dthKJdLYGxsiOoVyUMH18=;
        b=d/mCU/685SRCbZuUCGAfVKT6D9G6hjn2DJ9MDd6DnlHyoOpy3wE+L8zN9rCqKTEqt+
         pJHPYM3Lb2wDfJzSh7RkU0iKJ79ptalDEIQjYaw4c5nMmlrFVhZ8bEBWxe7rRNfcsM8C
         0ds6PikEf/gX2ognVjZvEjQp5hhJWmWdOG27FdyNq9yknRfDp5mcUZucsd0C2NKScuHX
         V3aOSTFe3i+z8Z8DjkfASK8rIM6C/xXcwHSQSZ1ypMvSTneAHwB58wqPLDGi/vl3pQ3t
         El50TFvfbsaPXjfUANJOSkLp4jquuNtPSPlnDiNmfgVxCGZ4tHd9v0cTBOKzvNZPaZ/m
         O6Lw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/62BkAit8nmX5d0nMYiugO3FwMEKNgHk0N+zX5xHdcSpZ7bQUIWQBRIpOCrLDqBJI/b6s=@ietf.org
X-Gm-Message-State: AOJu0YzaNf9/CSFk8TbzTx2H91x7xq2JRv/tx0jQCSj+WmCtWciTORuo
	jVXDtKohw1rR1AE6dI81DWKZ3O2FUCB8xk7UpnR1LbEAhe/BGZfELNrBtHXpUIpLPawTdQO7sIP
	tR5+QLVD+NuEBTzmV1zb9vr518v/tjHg=
X-Gm-Gg: Acq92OGAhq6zZSaJONgN+/Z5wNGn9+S7w45QRnLWGtLY70HD+sptFZM2pojIC1F5QJc
	zJbXnBt7nM3T7nV2IhvobHPp7aVHinaE9PvcBzO2tv/cbfYR+2Mgz7AMeLAqfpkg52KiALuP4YP
	RoicF/5mA/GHMgwjk/1/PCQrobLrfKdhrznnUnGN+uomLrWYgxePESAW1Nfk+OlaRr4v9WdS443
	we6ik2ofNA/19Qml/Hk4RFwrK6wfjWUUtXefQ326kNLDJ3XELJNKdBTcGkxNqOuKb7nvu/8wU7J
	7UIFCMVmxpvE8AB4cOMM0PKRAtP0qXSxGZNejxPyeqYT7b1vEeoEc6aq2+2sIwoOROaL6BFJXos
	a+Gg=
X-Received: by 2002:adf:f284:0:b0:45e:65a3:badf with SMTP id
 ffacd0b85a97d-45e65a3bb1fmr25476267f8f.21.1779293272731; Wed, 20 May 2026
 09:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-bpf-insn-doc-v1-1-74d7dada9bfc@bootlin.com>
 <ffe4e22a8e5d0fceefa7f9ecb378e038b4686aa417addd57d2af243b67607c0a@mail.kernel.org>
 <DINMD7Y3ZG8Q.3GZGX7SX9CN57@bootlin.com>
In-Reply-To: <DINMD7Y3ZG8Q.3GZGX7SX9CN57@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 May 2026 09:07:40 -0700
X-Gm-Features: AVHnY4LbSt-G1XJxIMtaJctIYbjx4r1-eMM68ioMxesYAe3uAgIIcikQLGh332g
Message-ID: <CAADnVQJx4xTU5L21bpjN8QeJTeSoeZRMknH_ZNPnY_DA1Yb8SQ@mail.gmail.com>
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Message-ID-Hash: TAYRFVIV3JEDSFDJGENPKZO7HS4WINCB
X-Message-ID-Hash: TAYRFVIV3JEDSFDJGENPKZO7HS4WINCB
X-MailFrom: alexei.starovoitov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bot+bpf-ci@kernel.org, David Vernet <void@manifault.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, ebpf@linuxfoundation.org,
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf <bpf@vger.kernel.org>,
 bpf@ietf.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next=5D_bpf=2C_docs=3A_add_LOAD=5FAQC?=
	=?utf-8?q?UIRE_and_STORE=5FRELEASE_instructions?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/EEen90bKVb_T9fSBvglULNXIJe8>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <20260520160740.Xi7Juoeoxhgi7fw375APJTX4OAGEF7Nkj94sKkVcKTk@z>

T24gV2VkLCBNYXkgMjAsIDIwMjYgYXQgNTo0NuKAr1BNIEFsZXhpcyBMb3Rob3LDqQ0KPGFsZXhp
cy5sb3Rob3JlQGJvb3RsaW4uY29tPiB3cm90ZToNCj4NCj4gT24gV2VkIE1heSAyMCwgMjAyNiBh
dCA1OjE4IFBNIENFU1QsIGJvdCticGYtY2kgd3JvdGU6DQo+ID4+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2JwZi9zdGFuZGFyZGl6YXRpb24vaW5zdHJ1Y3Rpb24tc2V0LnJzdCBiL0RvY3Vt
ZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0DQo+ID4+IC0t
LSBhL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlvbi1zZXQucnN0
DQo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vYnBmL3N0YW5kYXJkaXphdGlvbi9pbnN0cnVjdGlv
bi1zZXQucnN0DQo+ID4+IEBAIC02OTUsMjIgKzY5NSwyNCBAQA0KPiA+PiAgICAqKHU2NCAqKShk
c3QgKyBvZmZzZXQpICs9IHNyYw0KPiA+Pg0KPiA+PiAgSW4gYWRkaXRpb24gdG8gdGhlIHNpbXBs
ZSBhdG9taWMgb3BlcmF0aW9ucywgdGhlcmUgYWxzbyBpcyBhIG1vZGlmaWVyIGFuZA0KPiA+PiAt
dHdvIGNvbXBsZXggYXRvbWljIG9wZXJhdGlvbnM6DQo+ID4+ICtmb3VyIGNvbXBsZXggYXRvbWlj
IG9wZXJhdGlvbnM6DQo+ID4+DQo+ID4+ICAuLiB0YWJsZTo6IENvbXBsZXggYXRvbWljIG9wZXJh
dGlvbnMNCj4gPj4NCj4gPj4gICAgPT09PT09PT09PT0gID09PT09PT09PT09PT09PT0gID09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+PiAgICBpbW0gICAgICAgICAgdmFsdWUgICAgICAg
ICAgICAgZGVzY3JpcHRpb24NCj4gPj4gICAgPT09PT09PT09PT0gID09PT09PT09PT09PT09PT0g
ID09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+PiAtICBGRVRDSCAgICAgICAgMHgwMSAg
ICAgICAgICAgICAgbW9kaWZpZXI6IHJldHVybiBvbGQgdmFsdWUNCj4gPj4gLSAgWENIRyAgICAg
ICAgIDB4ZTAgfCBGRVRDSCAgICAgIGF0b21pYyBleGNoYW5nZQ0KPiA+PiAtICBDTVBYQ0hHICAg
ICAgMHhmMCB8IEZFVENIICAgICAgYXRvbWljIGNvbXBhcmUgYW5kIGV4Y2hhbmdlDQo+ID4+ICsg
IEZFVENIICAgICAgICAweDAwMDEgICAgICAgICAgICBtb2RpZmllcjogcmV0dXJuIG9sZCB2YWx1
ZQ0KPiA+PiArICBYQ0hHICAgICAgICAgMHgwMGUwIHwgRkVUQ0ggICAgYXRvbWljIGV4Y2hhbmdl
DQo+ID4+ICsgIENNUFhDSEcgICAgICAweDAwZjAgfCBGRVRDSCAgICBhdG9taWMgY29tcGFyZSBh
bmQgZXhjaGFuZ2UNCj4gPj4gKyAgTE9BRF9BQ1EgICAgIDB4MDEwMCAgICAgICAgICAgIGF0b21p
YyBsb2FkIHdpdGggYmFycmllcg0KPiA+PiArICBTVE9SRV9SRUwgICAgMHgwMTEwICAgICAgICAg
ICAgYXRvbWljIHN0b3JlIHdpdGggYmFycmllcg0KPiA+PiAgICA9PT09PT09PT09PSAgPT09PT09
PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4+DQo+ID4+ICBUaGUg
YGBGRVRDSGBgIG1vZGlmaWVyIGlzIG9wdGlvbmFsIGZvciBzaW1wbGUgYXRvbWljIG9wZXJhdGlv
bnMsIGFuZA0KPiA+PiAtYWx3YXlzIHNldCBmb3IgdGhlIGNvbXBsZXggYXRvbWljIG9wZXJhdGlv
bnMuICBJZiB0aGUgYGBGRVRDSGBgIGZsYWcNCj4gPj4gLWlzIHNldCwgdGhlbiB0aGUgb3BlcmF0
aW9uIGFsc28gb3ZlcndyaXRlcyBgYHNyY2BgIHdpdGggdGhlIHZhbHVlIHRoYXQNCj4gPj4gLXdh
cyBpbiBtZW1vcnkgYmVmb3JlIGl0IHdhcyBtb2RpZmllZC4NCj4gPj4gK2Fsd2F5cyBzZXQgZm9y
IHRoZSBgYFhDSEdgYCBhbmQgYGBDTVBYQ0hHYGAgY29tcGxleCBhdG9taWMgb3BlcmF0aW9ucy4g
IElmDQo+ID4+ICt0aGUgYGBGRVRDSGBgIGZsYWcgaXMgc2V0LCB0aGVuIHRoZSBvcGVyYXRpb24g
YWxzbyBvdmVyd3JpdGVzIGBgc3JjYGAgd2l0aA0KPiA+PiArdGhlIHZhbHVlIHRoYXQgd2FzIGlu
IG1lbW9yeSBiZWZvcmUgaXQgd2FzIG1vZGlmaWVkLg0KPiA+Pg0KPiA+PiAgVGhlIGBgWENIR2Bg
IG9wZXJhdGlvbiBhdG9taWNhbGx5IGV4Y2hhbmdlcyBgYHNyY2BgIHdpdGggdGhlIHZhbHVlDQo+
ID4+ICBhZGRyZXNzZWQgYnkgYGBkc3QgKyBvZmZzZXRgYC4NCj4gPg0KPiA+IFsgLi4uIF0NCj4g
Pg0KPiA+PiBAQCAtNzIxLDYgKzcyMywxMSBAQA0KPiA+PiAgdmFsdWUgdGhhdCB3YXMgYXQgYGBk
c3QgKyBvZmZzZXRgYCBiZWZvcmUgdGhlIG9wZXJhdGlvbiBpcyB6ZXJvLWV4dGVuZGVkDQo+ID4+
ICBhbmQgbG9hZGVkIGJhY2sgdG8gYGBSMGBgLg0KPiA+Pg0KPiA+PiArVGhlIGBgTE9BRF9BQ1Fg
YCBhbmQgYGBTVE9SRV9SRUxgYCBvcGVyYXRpb25zIGltcGxlbWVudCBsaWdodGVyIExPQUQgYW5k
DQo+ID4+ICtTVE9SRSBtZW1vcnkgYmFycmllcnMgdGhhbiBmdWxsIGJhcnJpZXJzLiBUaGUgY29y
cmVzcG9uZGluZyBhY2Nlc3NlcyBtdXN0DQo+ID4+ICtiZSBhbGlnbmVkLCBidXQgYXJlIGFsbG93
ZWQgZm9yIGFueSBhY2Nlc3Mgc2l6ZSAoOC1iaXQgdXAgdG8gNjQtYml0DQo+ID4+ICtvcGVyYXRp
b25zKS4NCj4gPg0KPiA+IERvZXMgdGhlIExPQURfQUNRIGRvY3VtZW50YXRpb24gbmVlZCB0byBj
bGFyaWZ5IGl0cyBub24tc3RhbmRhcmQgcmVnaXN0ZXINCj4gPiBzZW1hbnRpY3M/IEJQRiBhdG9t
aWMgb3BlcmF0aW9ucyBhcmUgZW5jb2RlZCBhcyBTVFggaW5zdHJ1Y3Rpb25zLCB3aGljaA0KPiA+
IGNvbnZlbnRpb25hbGx5IHVzZSBkc3QgYXMgdGhlIG1lbW9yeSBiYXNlIHBvaW50ZXIgYW5kIHNy
YyBhcyB0aGUgdmFsdWUNCj4gPiByZWdpc3Rlci4gSG93ZXZlciwgTE9BRF9BQ1EgcmV2ZXJzZXMg
dGhpcyBwYXR0ZXJuIGJ5IHVzaW5nIHNyYyBhcyB0aGUNCj4gPiBtZW1vcnkgYmFzZSBwb2ludGVy
IGFuZCBkc3QgYXMgdGhlIGRlc3RpbmF0aW9uIHJlZ2lzdGVyIGZvciB0aGUgZmV0Y2hlZA0KPiA+
IHZhbHVlLCBhY3RpbmcgbGlrZSBhbiBMRFggaW5zdHJ1Y3Rpb24uDQo+DQo+IFRydWUsIEkgY2Fu
IHNwZWNpZnkgdGhhdCBib3RoIGFyZSBhbnl3YXkgc3VwcG9ydGVkIGJ5IGEgU1RYIGluc3RydWN0
aW9uLg0KPg0KPiA+IEFkZGl0aW9uYWxseSwgc2hvdWxkIHRoZSBkb2N1bWVudGF0aW9uIGNsYXJp
ZnkgdGhhdCB0aGUgbG9hZGVkIHZhbHVlIGlzDQo+ID4gemVyby1leHRlbmRlZCBpbnRvIHRoZSA2
NC1iaXQgZGVzdGluYXRpb24gcmVnaXN0ZXIgZm9yIDgsIDE2LCBhbmQgMzItYml0DQo+ID4gYWNj
ZXNzZXM/IE9taXR0aW5nIHRoZXNlIGRldGFpbHMgbWlnaHQgbGVhZCB0byBpbmNvcnJlY3QgaW1w
bGVtZW50YXRpb25zDQo+ID4gYmFzZWQgb24gc3RhbmRhcmQgU1RYIHJ1bGVzLg0KPg0KPiBJIGd1
ZXNzIEkgY2FuIGFkZCB0aGlzIGRldGFpbCwgeWVzLg0KPg0KPiA+IFRoaXMgY29udHJhZGljdGlv
biBjcmVhdGVzIHNwZWNpZmljYXRpb24gYW1iaWd1aXR5OiB0aGUgZG9jdW1lbnRhdGlvbg0KPiA+
IHN0YXRlcyB0aGF0IExPQURfQUNRIGFuZCBTVE9SRV9SRUwgImFyZSBhbGxvd2VkIGZvciBhbnkg
YWNjZXNzIHNpemUNCj4gPiAoOC1iaXQgdXAgdG8gNjQtYml0IG9wZXJhdGlvbnMpIiwgYnV0IGVh
cmxpZXIgaW4gdGhlIGRvY3VtZW50IChsaW5lIDY3MSkNCj4gPiBleHBsaWNpdGx5IHN0YXRlcyAi
OC1iaXQgYW5kIDE2LWJpdCB3aWRlIGF0b21pYyBvcGVyYXRpb25zIGFyZSBub3QNCj4gPiBzdXBw
b3J0ZWQuIg0KPiA+DQo+ID4gVGhlIGluc3RydWN0aW9uIGVuY29kaW5nIHNlY3Rpb24gKGxpbmVz
IDY2Ny02NzEpIG9ubHkgZGVmaW5lcyB0d28gc2l6ZQ0KPiA+IGVuY29kaW5ncyBmb3IgQVRPTUlD
IG1vZGU6DQo+ID4gLSB7QVRPTUlDLCBXLCBTVFh9IGZvciAzMi1iaXQgb3BlcmF0aW9ucw0KPiA+
IC0ge0FUT01JQywgRFcsIFNUWH0gZm9yIDY0LWJpdCBvcGVyYXRpb25zDQo+ID4NCj4gPiBObyBl
bmNvZGluZyBpcyBzaG93biBmb3IgQiAoYnl0ZS84LWJpdCkgb3IgSCAoaGFsZi13b3JkLzE2LWJp
dCkgd2l0aA0KPiA+IEFUT01JQyBtb2RlLg0KPiA+DQo+ID4gSWYgTE9BRF9BQ1EvU1RPUkVfUkVM
IHRydWx5IHN1cHBvcnQgOC1iaXQgYW5kIDE2LWJpdCBzaXplcywgc2hvdWxkbid0IHRoZQ0KPiA+
IGVuY29kaW5nIHNlY3Rpb24gZG9jdW1lbnQgaG93IEIgYW5kIEggc2l6ZSBtb2RpZmllcnMgd29y
ayB3aXRoIEFUT01JQw0KPiA+IG1vZGUsIGFuZCBsaW5lIDY3MSBjbGFyaWZ5IHRoZSBleGNlcHRp
b24/DQo+DQo+IFRoaXMgcG9pbnQsIGFuZCB0aGUgY29ycmVzcG9uZGluZyBtZW50aW9ucyB0byB0
aGUgImF0b21pYzMyIGNvbmZvcm1hbmNlDQo+IGdyb3VwIiBhbmQgImF0b21pYzY0IGNvbmZvcm1h
bmNlIGdyb3VwIiwgbWFkZSBtZSByZWFsaXplIHRoYXQgdGhlIGtlcm5lbA0KPiBkb2Mgc2VlbXMg
dG8gYmUgaW4gc3luYyB3aXRoIHRoZSBlQlBGIElTQSBSRkMNCj4gKGh0dHBzOi8vd3d3LnJmYy1l
ZGl0b3Iub3JnL3JmYy9yZmM5NjY5Lmh0bWwpLiBJdCBtYWtlcyBtZSB3b25kZXIgaWYNCj4gaXQn
cyByZWFsbHkgb2sgdG8gYWRkIHRob3NlIExPQURfQUNRVUlSRS9TVE9SRV9SRUxFQVNFIG1lbnRp
b25zIGluIHRoZQ0KPiBrZXJuZWwgZG9jIG9ubHkgPw0KDQpJdCdzIG9rLiBJdCBhbHJlYWR5IGRp
dmVyZ2VkIGEgYml0LiBFdmVudHVhbGx5IHdlIHdpbGwgZG8gYW4gUkZDIHVwZGF0ZS4NCg0KLS0g
CkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4g
ZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==
