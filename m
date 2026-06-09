Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534154183B7
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010252; cv=none; b=axS8fsr/GRdsAOTMyzcEyPliLN7IjMRU0jkzd8Q3B6bITXdf9rN2tZKDS7iC/RJN7qZAdfvqIMPd3eg2AJdVvyeFHLKd2ie7lUw0vYCwtKQyqQPAMOOfZcF6y2d0u6etgMkHRA8wIBWEZxoHySC9IdBLowLacu0k+0t7pykyQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010252; c=relaxed/simple;
	bh=AHik3y1rFFAh2jFY0ef9fqt8T+dLqSNzfLG+Vm8k4EU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6rB2Sgp8uLP6HQhDDtw5W3vbHbFEqa0cx7QwB2rXHILX65SVsnbGIK6v1I5wi/MZz+LRv1+CbM3G70rtI0ea8NaelM6HGdoTiItAp1zY7Ii6CZWI4T+OmkxEaxP/jTZ8XTo2ECN4dad5SalPnra5Yjluy7dUisZyWUT/9WAlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw6KkLjz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AG9p3Eok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw6KkLjz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG9p3Eok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781010248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AHik3y1rFFAh2jFY0ef9fqt8T+dLqSNzfLG+Vm8k4EU=;
	b=dw6KkLjzZxUtRtpWibLYT1ARvofDg6qNPDk/gPXqWUQeOHM1RlI/smaFgtH2HDbEXFSiy8
	9ukfXlc37JolM2kbW9tJkdJpwo+gKzodFOutefMAxHDDthXjxBwgkznJS+IAM+UEePuQ2y
	8A5p9r3Wsq7pAYVuA85P6OIkyayjDK8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-ELklYPDbPeadUKUHdSGS3Q-1; Tue, 09 Jun 2026 09:04:06 -0400
X-MC-Unique: ELklYPDbPeadUKUHdSGS3Q-1
X-Mimecast-MFC-AGG-ID: ELklYPDbPeadUKUHdSGS3Q_1781010246
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae3bcf4cso26740335e9.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781010246; x=1781615046; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AHik3y1rFFAh2jFY0ef9fqt8T+dLqSNzfLG+Vm8k4EU=;
        b=AG9p3EokQEnyJHPmHFZV3iSgeH9+SGNiazP5fPXJHBaFyFQp3zU8de1B2QPYnMeBbX
         FOTz6djzKUrkcOVTtiYCzhC4bCtyN9dEzDbAW6MB3js+uTvYWwPkt/1tcISc/8sR1EL8
         ljddYOJPcrKlE86aBaz3AzUH8jxd0788q8Nhm+qblVk5t6ImyAv0yI4fbNxgExseodqD
         VMzxzAr8PjiAkV6+X614Gp3dA0SQDDqG/cPGKizpyGVbj4Q4Z4jkcdP504rslmk33huF
         Q4ab+y3DzHrN5FiEEGhqgREATUxVeZ1ZFP9Di9AURJT7U08FoxfhId2+u6hH1hGCNLIl
         y+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781010246; x=1781615046;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHik3y1rFFAh2jFY0ef9fqt8T+dLqSNzfLG+Vm8k4EU=;
        b=rQMz80YBUnoeCWg0DhxF5cfBlCOO70u5IsAB+rXdLvLqyK/qrpqhaErIwLMs3mckvg
         s/MElMjyiqo5Dij8Rcmlg/kmLcQ0/qkHYx7hdgKGunK2InCIhz/fylO8A/u6h6HbcBE+
         SMMlJ4Lhtsmr0ZEWZPSm55fEQsxZqAQARYBZVXkSmEaT2gB+taAH55cZhY9pnuYySCWZ
         ogv0Zm6XNFj7mr1hq7PTpwI5kiHysrIGS576zYsBsOQh7kQ+DmlJULomLQYNAJMKWLEl
         9w3Jl1TlaWdA2LLGYge3o6nRiKl5FDBC6/X/MRi4r+tTWWiM2LaMp3HkZ0TTrxZNNB3V
         ZTpw==
X-Forwarded-Encrypted: i=1; AFNElJ+4kduIryozic64HuTOQ8lzevuy1Q3FSX0H75xhYWVG3KFdJ9qODNtzf1JAMOoWMJcdO1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqCYD+SITZ5PT2r56i373rLvHq9beZltx7p9DTujgGmpxDEdZ
	hIID1CwykuuRFnPSu4L8fkZi2V+dqdGEoB/NDZPuH5Z9+YG332A1lSISn0IPlMSlEW4GxlFgKzI
	bgjxBZLjWHZmBBSxwUMZxVhXpaHzJ5XcNzp8dqa7qIX0wYswxOK8zqWzbeMQBbA==
X-Gm-Gg: Acq92OG1KIL6ubzYgOJqJMPB8Ev1JxbSRf7l9MxyvyJRJS80lrCVakPjmAK4nDc4Z+2
	l7XgUhp1LBY9b3FzU8nu7niuSBclbf3QvEBN8M1dzmgBzt+4bfw7XFyomQ0fpokmK5W2nzH/INZ
	WkoJv9YMGEIqCGtMiSsOV5wzkn5/1gmorC1dm2TRSqWIGlR9aX5TZQl9Sk8Bb1hy+6Fy52o7V2r
	kY0gL4bBeurHl/T5MueBSOB+jS+Ujk7GKm/cFfzqbrSfLUPIzmXqpCi/umX43itQ2DJWeI1JzVo
	HcQcpx1BvIFU0dXqysBWq2fHVCYHWWZAbmDYwDlUUF69Lxu999KwJ+leMTqSpZzas0KsPVIJ0O7
	aM9UUyn5qXl23DDR9b4E8Fe+sx6lITyXEAQ4F
X-Received: by 2002:a05:600d:8648:10b0:490:d354:bd0a with SMTP id 5b1f17b1804b1-490d354bef4mr61259205e9.31.1781010245715;
        Tue, 09 Jun 2026 06:04:05 -0700 (PDT)
X-Received: by 2002:a05:600d:8648:10b0:490:d354:bd0a with SMTP id 5b1f17b1804b1-490d354bef4mr61258885e9.31.1781010245374;
        Tue, 09 Jun 2026 06:04:05 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm425564445e9.1.2026.06.09.06.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:04:04 -0700 (PDT)
Message-ID: <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to
 allow schedule
From: Gabriele Monaco <gmonaco@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya
 Dwivedi	 <memxor@gmail.com>, bpf@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, 	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>
Date: Tue, 09 Jun 2026 15:04:03 +0200
In-Reply-To: <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
References: <20260609094941.56122-1-gmonaco@redhat.com>
	 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI2LTA2LTA5IGF0IDEzOjIyICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+
IFNob3VsZCB0aGlzIGJlIENjOnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmfCoHRvIGdldCBiYWNrcG9y
dGVkPwoKTm90IHN1cmUgaWYgdGhlIEZpeGVzOiBpcyBlbm91Z2ggdG8gdHJpZ2dlciB0aGUgYXV0
b21hdGlvbiwgSSByYXJlbHkKcmVtZW1iZXIgdG8gQ2M6c3RhYmxlQHZnZXIua2VybmVsLm9yZyBh
bmQgdGhleSdyZSB1c3VhbGx5IHBpY2tlZC4KCkluIGNhc2UgSSBndWVzcyBJJ2QgbmVlZCB0byBy
ZS1zdWJtaXQgdGhlIHBhdGNoIHJpZ2h0PwoKPiBEaWQgeW91IHNlZSB0aGlzIGNhdXNlIG1lYXN1
cmFibGUgcGVyZm9ybWFuY2UgcHJvYmxlbXMsCj4gb3IgZGlkIHlvdSBmaW5kIGl0IHRocm91Z2gg
aW5zcGVjdGlvbj8KCkkgbm90aWNlZCBpdCB3aGlsZSBkZWJ1Z2dpbmcgYW4gRU5PTUVNIGlzc3Vl
IGluIHRoZSB0ZXN0X21hcHMgQlBGCnNlbGZ0ZXN0IG9uIFBSRUVNUFRfUlQgYW5kIHRoaXMgd2Fz
IGFuIG9idmlvdXMgY3VwbHJpdCAoaXJxX3dvcmsgbm90CnNjaGVkdWxlZCBkdXJpbmcgYSBzdHJl
c3MgcnVuKS4gVHVybnMgb3V0IHRoZSBwcm9ibGVtIGlzIHN0aWxsIHRoZXJlCmFmdGVyIHRoaXMg
Zml4IHRob3VnaC4KCj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYWJyaWVsZSBNb25hY28gPGdtb25h
Y29AcmVkaGF0LmNvbT4KPiAKPiBBY2tlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT4gIyBhc20tZ2VuZXJpYwoKVGhhbmtzLApHYWJyaWVsZQoKPiAKPiBUaGlzIHNob3VsZCBwcm9i
YWJseSBnZXQgbWVyZ2VkIHRocm91Z2ggdGhlIEJQRiB0cmVlLCBidXQgSSd2ZQo+IGFkZGVkIHRo
ZSBrZXJuZWwvbG9ja2luZyBtYWludGFpbmVycyB0byBDYyBhcyB3ZWxsLCBzaW5jZSBJCj4gZmVl
bCBpdCdzIG1vcmUgdXNlZnVsIHRvIGhhdmUgdGhlbSBsb29rIGF0IGl0IHRoYW4gbWUuCj4gCj4g
TWF5YmUgaXQgd291bGQgYmUgZ29vZCB0byB1cGRhdGUgKGFzIGEgc2VwYXJhdGUgcGF0Y2gpIHRo
ZQo+IE1BSU5UQUlORVJTIGZpbGUgc28gdGhlIGxvY2tpbmcgc3Vic3lzdGVtIGFsc28gaW5jbHVk
ZXMgdGhlCj4gaGVhZGVycyBjdXJyZW50bHkgbWlzc2luZzoKPiAKPiBhcmNoLyovaW5jbHVkZS9h
c20vKnNwaW5sb2NrKi5oCj4gYXJjaC8qL2luY2x1ZGUvYXNtLypyd2xvY2sqLmgKPiBpbmNsdWRl
L2FzbS1nZW5lcmljLypzcGlubG9jayouaAo+IGluY2x1ZGUvYXNtLWdlbmVyaWMvKnJ3bG9jayou
aAo+IAo+IMKgwqDCoMKgwqDCoCBBcm5kCj4gCj4gKGZ1bGwgcGF0Y2ggcXVvdGVkIGJlbG93KQo+
IAo+ID4gLS0tCj4gPiDCoGluY2x1ZGUvYXNtLWdlbmVyaWMvcnFzcGlubG9jay5oIHwgMTQgKysr
KysrKysrKystLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5lcmljL3Jxc3Bp
bmxvY2suaCAKPiA+IGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9ycXNwaW5sb2NrLmgKPiA+IGluZGV4
IDE1MWQyNjdhNDkuLjRkNDY2NDNmNDYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2FzbS1nZW5l
cmljL3Jxc3BpbmxvY2suaAo+ID4gKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9ycXNwaW5sb2Nr
LmgKPiA+IEBAIC0yNDMsMTIgKzI0MywyMCBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQg
Cj4gPiByZXNfc3Bpbl91bmxvY2socnFzcGlubG9ja190ICpsb2NrKQo+ID4gwqAJKHvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgXAo+ID4gwqAJCWludCBfX3JldDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+IMKgCQlsb2NhbF9pcnFfc2F2ZShmbGFncyk7
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiAtCQlfX3JldCA9IHJhd19yZXNfc3Bpbl9sb2Nr
KGxvY2spO8KgIFwKPiA+IC0JCWlmIChfX3JldCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICsJCXByZWVtcHRfZGlzYWJsZSgpO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArCQlfX3JldCA9IHJlc19zcGluX2xvY2sobG9jayk7
wqDCoMKgwqDCoCBcCj4gPiArCQlpZiAoX19yZXQpIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gwqAJCQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7IFwK
PiA+ICsJCQlwcmVlbXB0X2VuYWJsZSgpO8KgwqDCoMKgwqDCoMKgwqAgXAo+ID4gKwkJfcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXAo+ID4gwqAJCV9fcmV0O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBcCj4gPiDCoAl9KQo+ID4gCj4gPiAtI2RlZmluZSByYXdfcmVzX3Nw
aW5fdW5sb2NrX2lycXJlc3RvcmUobG9jaywgZmxhZ3MpICh7IAo+ID4gcmF3X3Jlc19zcGluX3Vu
bG9jayhsb2NrKTsgbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOyB9KQo+ID4gKyNkZWZpbmUgcmF3
X3Jlc19zcGluX3VubG9ja19pcnFyZXN0b3JlKGxvY2ssIGZsYWdzKSBcCj4gPiArCSh7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArCQlyZXNfc3Bpbl91bmxvY2sobG9jayk7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gKwkJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpO8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICsJCXByZWVtcHRfZW5hYmxlKCk7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICsJfSkKPiA+IAo+ID4gwqAjZW5kaWYgLyog
X19BU01fR0VORVJJQ19SUVNQSU5MT0NLX0ggKi8KPiA+IAo+ID4gYmFzZS1jb21taXQ6IGU0M2Zm
YjY5ZTA0MzhjZGRkNzJhYWEzMDg5OGI0ZGM0NDZmNjY0ZjgKPiA+IC0tIAo+ID4gMi41NC4wCg==

