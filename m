Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951B2C2365
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=166.84.6.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194744; cv=fail; b=YAHhVc5R7YKzNtuK1xGPQ3hez8mlVR29JaADnoIna9SA+Q0e+dvoF6E1c6zj5KYDcg1hdlcnvOtIoYzFNZw6fpE0siEGC77GbuL+lzeBFBpGvMn7LoQS8ktd3k1MVNb4yXzHrkGdeqn3SUe8uwE18HHwZ3bGdyjjVnS24Qt3R4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194744; c=relaxed/simple;
	bh=wgUNXyKIeRs082Ra/w+mNIXII/OUQVbhc1B31P6FxIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:To:CC:
	 Subject:Content-Type; b=VTFL51Zmaw7uyHXDywohVj4m4sgwFPxf9EOpD4vx38TH1MAezFwAtEZAOqROrOW8GP956oZhxQaStgGTk1kkQXY3BRkDu/3GtLpofSzSQl2NZHX4bw9H35xcgw5ojCwZLjG9Ou0c4q3DJeCjvYc4MsPItjui4yCrjS4DAy3tzro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=m0hN1uUo; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKW4BQWQ reason="signature verification failed"; arc=fail smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="m0hN1uUo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKW4BQWQ"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 1AAF4AC26D2D
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1769194729; bh=wgUNXyKIeRs082Ra/w+mNIXII/OUQVbhc1B31P6FxIA=;
	h=References:In-Reply-To:From:Date:To:CC:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe;
	b=m0hN1uUovJol/WpAjyvaGn9y3BiirssA+mvMQTHE63Lt0OWFWxgd7WLGhIm6G0sM9
	 3IBnpWd7W/x5WtlB08ZncPgc/Vhi0suv50a3SYhVvpy5l+bMTzjnteU39EXxTHV9JE
	 MGW6kxGNY79pV/33XPo4xvgbALJukVakQcEtKR20=
X-Mailbox-Line: From bpf-bounces+bpf=vger.kernel.org@ietf.org  Fri Jan 23 10:58:49 2026
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 1360AAC26D2A
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:58:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 55EF9AC26BA1
	for <bpf@mail2.ietf.org>; Fri, 23 Jan 2026 10:58:43 -0800 (PST)
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
	header.d=gmail.com
Received: from mail2.ietf.org ([166.84.6.31])
	by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kSeLRx7T-DpC for <bpf@mail2.ietf.org>;
	Fri, 23 Jan 2026 10:58:42 -0800 (PST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail2.ietf.org (Postfix) with ESMTPS id B4396AC26A15
	for <bpf@ietf.org>; Fri, 23 Jan 2026 10:57:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1640143f8f.2
        for <bpf@ietf.org>; Fri, 23 Jan 2026 10:57:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769194666; cv=none;
        d=google.com; s=arc-20240605;
        b=MQ9f4KPBDvwSVIoS/7JsP2zVfIylfo9qgtecWTGtf8UIsN4VOn4Z+q2OYKduUx3Cpw
         zzzfCl9D74qmlA8hPiQoA/GeDRDayL4+VHe94JdLRZxpsJMppu42GG2fyxBxnn1NEGL6
         fwu+8/QoDrizx09viVPo270Pe9Fz2WnXkDexl5Xcedl4bzScmGVS94db+IE8hWds4bk4
         6obOA3my2uMm7Ska+CRRGBDqZCWndMfIkpgbKeA7+1UyxEwFH1QmGlWNcTdp4AmeZrx1
         Al6AvXf5yvhxFr9ao91uniaxfQVlQs7XW54Ur7u2NtaXxYNHjrRdCGsozr3JqXBFJuMo
         7fAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWDQCp15baqJ4aAP8bX3vbVpR/UO3uYWRgULkeu55iA=;
        fh=SyvIavOfW5gfi/jtc4W7R5vNDd9utXqcCQgi7hj8iKU=;
        b=dpoKTU0caWEj8KwRKfT9T5vJ6igquzEPY+Dr0H0CN2W8TCBhp9m5j8y81Pbk+2ALkT
         3qOnhgqBq4zg6uARJfLTXfWGuZoOv3uP2U5YdEbYuNRTN1oQmLvQzkL4YcTTp30yWjTS
         FfiC1d0BE7JklXKqy/S0z0tuJ4NNfk6ofgXsJ/bIXkH7mn61+18z2Vfu/2Vua8E1s0sq
         K2jarOeSo1NQfgGXwpwxcl+pbx97YbPty+7bhTwBK0seG64Jiv547Q+UWtfhzspO1sHw
         zQIBR5adnkJW69bH2KESDV4uxL4FFeAe6Mt6BiMdyGHe220EkcTV242lyjiixwY63R4F
         giVg==;
        darn=ietf.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194666; x=1769799466; darn=ietf.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWDQCp15baqJ4aAP8bX3vbVpR/UO3uYWRgULkeu55iA=;
        b=LKW4BQWQks4EP7gy+ABkDeXENaaX4sdh1QQxzPeYdmHWUIkfhkKRqJ55HB3twuRAYI
         10gFbCteeU3Rcl9NxcytqMAgeasoE9g0waCZCavRwTb1w+oalMkgDxnSxjdhHdk+xeYO
         3dF9AvPP5x0Swof1nuHKAXbxvDn7tQfvN9OOF6tiOnWM2Kx4Dlg4O8j9d7aig/wF9iA+
         VeUn99MclCwHyPEbq/sGy20sHM5WeO8IBKsUQ8bw9n6EjW+NngaxXr4UfEuxqhCg51Mu
         0hhKGaIOCk73bO/xyaOTJm5AvVEZLmeSlvcmz9GwDhmvKZsLkCPE/8ToS0ygydQbbXa5
         Jgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194666; x=1769799466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rWDQCp15baqJ4aAP8bX3vbVpR/UO3uYWRgULkeu55iA=;
        b=pHCMLT3/KYUmfHNwrQBZETUxXd8ppQ3sTZqfIt8KSojwSBoJnCmWweX3MPoai0FP+r
         bBBgtFtoqIzx0NXQxgOFhEtu98/xlgHZ0vnM2ABO5xGSG/wV9SA5K28Hcmp/faPNzcPj
         9GBbJz5h8KmCklK9m/G12mHgRO71q/cGQJxzDVsp7qmVsvdYyBxrhb0sbDxFYBdAIwBh
         ohpZOY5BTlWytZCvh6cN1sBmSK1fRR4Z9jhhYK4vNMc3PHixAt3zavmQBGCPYMf1vBk4
         hK77vYy+pfbmjuTDnvAsdXV0BqU58ihRNH1bMOgUNxz/iLcW1joCFzSRo/E82adi3mRe
         IuRw==
X-Gm-Message-State: AOJu0YzU+59NYCPIbFmWtzHW/boMu7TeRFE+ZBZabrswwG3haVyBjLMv
	n9X8PLHVwG0LXw2NDwaLiYsOUZicS2zgsauecCjM6fi4mQy3+lSBWNVIvHdAanb8cHvTZKJ/97g
	eAIOU7eSFPV0b60iXi+zlVTW2i8ecaFo=
X-Gm-Gg: AZuq6aL8g7HbmM+9Jh5m6aCBWanDfw7GP65l2Zx1MeVlt7tkIu3x93aMqKaPy4SQQR7
	qp/1J+MOinkYKFjAvIGGLvMubNJLng5ORtZFrsGlDlynvk+WnDrhcw7F0u4CxmrG3H+FHcvoE2v
	wZ5OO20/bu0xQyrbEd808yUozkLOKAOPNRmpzNrw+8YfeSXYIMZC4a7e3mhNBwreSwwHDx6yOG1
	tpMH7eeL0PJJQigIw6G4ZljykH1XA687NoRE3uW4IJp0KALPCYMt8x/pH8B1+kr4+U3lvt9mCXa
	PbzUZA4+HIGcBrs+y//kCQK3fkjL+R7MidPtGi0bZvJ5DVSNCZlme+A3e6JQpIBToHWLImp1
X-Received: by 2002:a05:6000:178c:b0:435:9690:f056 with SMTP id
 ffacd0b85a97d-435b15fafe2mr6917717f8f.35.1769194665619; Fri, 23 Jan 2026
 10:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be1a66a-2594-404c-9c6f-cd36e1eaf684@gmail.com>
 <a46cfa94-fbc4-4fc1-8042-230055af412e@gmail.com>
In-Reply-To: <a46cfa94-fbc4-4fc1-8042-230055af412e@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 10:57:34 -0800
X-Gm-Features: AZwV_QiXcmZBYVXUxNEnBOv8YsYh6rzr6Qjp1uOUfFHnVT-n777FDYNLOqnUNB8
Message-ID: <CAADnVQJ_JQGWRMW3LxsHiEKOf3on11XVeRLgtMv4VjUNM0pjew@mail.gmail.com>
To: Tristan Itschner <tristan.itschner@gmail.com>, bpf <bpf@vger.kernel.org>
Message-ID-Hash: NZ44UM3CYYO5BKIG6XPCADDPXR6C63KD
X-Message-ID-Hash: NZ44UM3CYYO5BKIG6XPCADDPXR6C63KD
X-MailFrom: alexei.starovoitov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia;
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: bpf@ietf.org
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_Undefined_behavior_in_eBPF_RFC?=
Archived-At: 
 <https://mailarchive.ietf.org/arch/msg/bpf/fv1JW39xwfcw877x24vd1IgpHIg>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <20260123185734.Kpcb6l4q5EXQAgeY-2jQ8W-qhReIvpWXS8Njg02vJbw@z>

T24gU2F0LCBEZWMgMjAsIDIwMjUgYXQgNjo0M+KAr1BNIFRyaXN0YW4gSXRzY2huZXINCjx0cmlz
dGFuLml0c2NobmVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IEhpIHRoZXJlIGFnYWluLA0KPg0K
PiBmaXJzdCBvZiBhbGwsIEkgd291bGQgbGlrZSB0byBhcG9sb2dpemUgZm9yIHRoZSB1bnByb2Zl
c3Npb25hbCB0dW5lIGluDQo+IG15IGluaXRpYWwgbWVzc2FnZS4gU29ycnkgZm9yIHJlYWxpemlu
ZyB0aGF0IG9ubHkgaW4gcmV0cm9zcGVjdC4NCj4NCj4gTXkgY29uY2VybiB3YXMgYXMgZm9sbG93
czogSW4gcGlwZWxpbmVkIFJUTCBDUFUgaW1wbGVtZW50YXRpb25zLCBpdA0KPiBtYWtlcyBhIHNp
Z25pZmljYW50IGRpZmZlcmVuY2UsIHdoZXRoZXIgdW5hbGlnbmVkIG9yIG9ubHkgYWxpZ25lZCBs
b2Fkcw0KPiBhbmQgc3RvcmVzIGFyZSBhbGxvd2VkLiBJbXBsZW1lbnRpbmcgdW5hbGlnbmVkIGxv
YWRzIHJlcXVpcmVzIHF1aXRlIGENCj4gYml0IG1vcmUgbG9naWMsIGVzcGVjaWFsbHkgd2hlbiBv
cHRpbWl6aW5nIGNlcnRhaW4gZmFzdCBjYXNlcy4gS25vd2luZw0KPiBmcm9tIG15IGJhY2tncm91
bmQgdGhhdCBjQlBGIHJlcXVpcmVzIHVuYWxpZ25lZCBsb2FkcywgSSBhc3N1bWVkIHRoYXQNCj4g
ZUJQRiBkb2VzIHRoZSBzYW1lIGluIHByaW5jaXBsZS4gTXkgY29uY2VybiB3YXMgdGhhdCBzb21l
b25lIG9ubHkNCj4gaW1wbGVtZW50cyBhbGlnbmVkIGxvYWRzIGFuZCBzdG9yZXMgaW4gYW4gZUJQ
RiBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbiwNCj4gYmVjYXVzZSBpdCBpcyBub3QgZXhwbGljaXRs
eSBzdGF0ZWQuIEluIGZhY3QsIHRoZSB3b3JkIGFsaWdubWVudCBkb2VzDQo+IG5vdCBhcHBlYXIg
YXQgYWxsIGluIHRoZSBSRkMuIFRoaXMgd291bGQgYnJlYWsgaml0dGluZyBjQlBGIHByb2dyYW1z
IHRvDQo+IGVCUEYgcHJvZ3JhbXMsIGJlY2F1c2UgdGhlbiB0aGUgYmVoYXZpb3Igb2YgdW5hbGln
bmVkIGxvYWRzIGlzDQo+IHVuZGVmaW5lZC4gQnV0IHlvdSB3b3VsZCBub3Qgbm90aWNlIGl0IGlu
IHByYWN0aWNlIGlmIHlvdSB3ZXJlIG9ubHkNCj4gdXNpbmcgQyBwcm9ncmFtcywgYmVjYXVzZSB0
aGUgY29tcGlsZXIgb25seSBnZW5lcmF0ZXMgYWxpZ25lZCBsb2FkcyBhbmQNCj4gc3RvcmUgKHVu
bGVzcyB5b3UgdGVsbCBpdCB0byBkbyBvdGhlcndpc2UpLiBUaGlzIGlzIG9ubHkgYW4gaXNzdWUg
aW4gdGhlDQo+IGNvbnRleHQgb2YgcHJvY2Vzc2luZyBwYWNrZXRzIHdpdGggdmFyaWFibGUgaGVh
ZGVyIGxlbmd0aCwgc3VjaCBhcyBpcw0KPiBkb25lIHdpdGggY0JQRi4gQnV0IGNCUEYgaXMgZW5v
dWdoIGZvciB0aGF0IG9mIGNvdXJzZS4NCj4NCj4gSG93ZXZlciwgSSBoYXZlIHJlYWxpemVkIG5v
dyBieSByZS1yZWFkaW5nIHRoZSBzcGVjLCB0aGF0IGVCUEYgYWxsb3dzDQo+IG9ubHkgYWxpZ25l
ZCBsb2FkcyBhdCBhbGwgKEkgbWlzcmVhZCB0aGUgQy1saWtlIHN5bnRheCksIHdoaWNoIG9mIGNv
dXJzZQ0KPiBtYWtlcyBhIGxvdCBtb3JlIHNlbnNlIGZvciB0aGUgYWN0dWFsIHVzZS1jYXNlcyBv
ZiBlQlBGLg0KPg0KPiBJIGhvcGUgeW91IGRvIHVuZGVyc3RhbmQgbm93IHdoZXJlIEkgd2FzIGlu
aXRpYWwgY29taW5nIGZyb20uIEknbSBhIGJpZw0KPiBmYW4gb2YgYm90aCBCUEYgaW1wbGVtZW50
YXRpb25zLCBzbyBwbGVhc2UgZG9uJ3QgZ2V0IG1lIHdyb25nLiBCdXQgbXkNCj4gY29uY2VybiBp
cyB1bmZvdW5kZWQgYmVzaWRlcyBiZWluZyB1bmRlcnN0b29kIGFzIGEgc3VnZ2VzdGlvbiB0byBj
bGFyaWZ5DQo+IHRoYXQgYmVoYXZpb3IgaW4gdGhlIFJGQy4NCj4NCj4gQmVzdCByZWdhcmRzLCBU
cmlzdGFuIEl0c2NobmVyDQoNCkhleSwNClNvcnJ5IGZvciB0aGUgZGVsYXkuDQoNCmVCUEYgYWN0
dWFsbHkgYWxsb3dzIHVuYWxpZ25lZCBsb2Fkcy4NClNlZQ0KaHR0cHM6Ly9kb2NzLmVicGYuaW8v
bGludXgvc3lzY2FsbC9CUEZfUFJPR19MT0FELyNicGZfZl9hbnlfYWxpZ25tZW50DQoNCkJQRl9G
X0FOWV9BTElHTk1FTlQgYW5kIEJQRl9GX1NUUklDVF9BTElHTk1FTlQgZmxhZ3MuDQoNCkl0J3Mg
bm90IGRvY3VtZW50ZWQgZXhwbGljaXRseSBpbiB0aGUgc3BlYywgYnV0IGFueSBuZXcgSFcgb3Ig
U1cNCmltcGxlbWVudGluZyBzdXBwb3J0IGZvciBlQlBGIG11c3Qgc3VwcG9ydCB1bmFsaWduZWQg
bG9hZC9zdG9yZQ0Kd2l0aG91dCBoZWF2eSBwZW5hbHR5IGxpa2UgYSB0cmFwLiBPdGhlcndpc2Ug
aXQgd2lsbCBicmVhaw0KcGVyZm9ybWFuY2UgZXhwZWN0YXRpb25zIG9mIGVCUEYgcHJvZ3JhbXMu
DQoNCi0tIApCcGYgbWFpbGluZyBsaXN0IC0tIGJwZkBpZXRmLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGJwZi1sZWF2ZUBpZXRmLm9yZwo=
