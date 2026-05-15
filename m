Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A430C16B
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869456; cv=none; b=KK4IEIRubKfz1muG0aKOhVAGy4KBNybjz3NUoQWQOBcy8GmFw9pwuCPQgvy4wVFciIG2a7oPv3R5mP1m+Gbzrrm8nMeMI/jnS3Yk2ZJphZevrl45cXGtSiWkPtaiFzHJUcI40iyVdgheQVQF/cXeou3fKQHS2KL3OPaP1EoByns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869456; c=relaxed/simple;
	bh=Pz/n8pzBCTF/qxxU0DwuXfYLZLhJc4Nh66lSbms7oQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMjqZaBaOIYWsgPp0PmGM96Hvt3d+0G8gOFtvbbWgYEGxd4g99P+54GDjrWlIBPSD2hkr7Zbpzbsp/oLji1JpT+sKbOZTm3rrtBp9lJT9YgZwueoc8KcBK1o9I2DaF28K0q5CuTDxSablFhSDHYob1wxSrrVULieilcHORZKm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn5c2mt6; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn5c2mt6"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c19d23b19so105222c88.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778869454; x=1779474254; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pz/n8pzBCTF/qxxU0DwuXfYLZLhJc4Nh66lSbms7oQk=;
        b=Qn5c2mt6Uo51qinnh6gVpmf/AtiwGSDWpHGDEbgFfsdehJPihiR2YKZZ/lfjMCn0PO
         +ZX9vKvZlGFBmfK5uQmQ0PrY85YFf3JUQ+6Ze+02oTDrDuYa1rJKWg1rw7Upd2bKRbYc
         pcv/DeX5lZ9VYyhcxCZZMjVZv5dfNunyrjXB1y+Dl3a/Cf10Xcx1Vt4DQSOj+0nSgW2y
         T/8No3A1exnQNsZl0kVcMTpusGziVmUrELHf04H1SJD4BLj+NuuC6q/I/DWjWbIxfz87
         5+PRV/1IgaT0vOJK6ij/53ZMrn3TeAfW+TPCHwSQtfLYHqvWSDNXa73ji/iyC3b8sLtV
         OXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778869454; x=1779474254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz/n8pzBCTF/qxxU0DwuXfYLZLhJc4Nh66lSbms7oQk=;
        b=imaoGOcMCR9mgNTv+laChkIEJh61N0h8Vb1db04RzkChEB1tGZ+z8QEkpz/RNc+rFI
         +CpXUuR0dshmJzrXCEV1UgY3AGlmi3SkydeoaWnzlaNNxDGPQUmnM5Yj0yraECIZC5nZ
         95KoyAaNhISBzo6hSbjbo3YUTROaog8bLvnng4thlbDpnCdOd73Nl6/QznXjtdwCBscp
         LDKlmBWsTHc2cOEXVVfWqRkBcyFswu0774wNo7KV00qGlnJZ7bq/0fWW/T+hVxeIWzy8
         irDG+KRyB0YJz/QhUe5kY99lyww6lsY4eKJPx8gqOrhNDuDaoF680BZVT3VyIzVya2o1
         bxMw==
X-Gm-Message-State: AOJu0Yz8xzn9F/htEUu1qQTQzQWEe+A3f+6jZf49qaEnfsz67BT6J/v4
	fKfA+t63txH4q+dzkGbwWC1bVbvjb2p20hkYA+9WEZjtglSOn7Mpnjnw
X-Gm-Gg: Acq92OFOgx/i08hslL0xSdqeG9yFy63Ql7qoJxXdnpug9XQ7aiJiwNQLMxXyd448hi+
	11aqTiRHIhseMEML3TbiqU9dgB9Y8Y5imWC8/F7u4Z16KCpAarYrlRw2olpa5XYt6JG7sjzG0L8
	3T/MTZbaYfuszzncO26LruZ7/iS6E+7y/xRcezI5oVrMP4FjGS5gxZ08fLI9Ggz+a27I+EaAnxG
	4GuGbpUGpNFXBqZS9cUakEeFOZ8gKrlfZC99OOEyVdn6b1QkdY84Dj1klx99XVIMEIei8G48Q+X
	9HdHLFsmEDkK4N7boBbPDIulKR/p0rOgpun7JSh2AhC45rZEuEDpzz4jkOsyfMEGoySPNYj1ZaE
	bGLaT1pyiFHoCXfRYOgVPSuhWJ65/E9MLWMMBBVKqsfbow4IttVDtDEtoQkmSzDI3C7BJ9J2R+r
	Qo007Ba0Uc9HAJY8gcDea9P3nMl4zOWlO8+zUmdyc2y8UwMMZqpyG6m71817xOKVIf6IIWm/q6b
	RHQpzf8
X-Received: by 2002:a05:7022:6992:b0:132:5d96:39d4 with SMTP id a92af1059eb24-13504948b8amr2078797c88.42.1778869453673;
        Fri, 15 May 2026 11:24:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:d03c:ddf4:698e:1a06? ([2620:10d:c090:500::3:38b6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351c3sm11275238c88.11.2026.05.15.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:24:13 -0700 (PDT)
Message-ID: <7fa6794161a8bd4fdbc21dad68e86e9770c873cc.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and
 unlink before drop
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, ast@kernel.org, memxor@gmail.com,
 corbet@lwn.net, 	martin.lau@linux.dev, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, 	yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, 	sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, skhan@linuxfoundation.org, vmalik@redhat.com, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev, bot+bpf-ci@kernel.org
Date: Fri, 15 May 2026 11:24:09 -0700
In-Reply-To: <0fb2d99b-b122-44fa-a8bc-9befe6e350bc@linux.dev>
References: <20260512055919.95716-3-kaitao.cheng@linux.dev>
	 <da95f45b43d94d17796b19abc4c555e35daafab7d5e1cdca3714fe0f54ab8cce@mail.kernel.org>
	 <e141699dab70282d811ec30bbf2aa8279706817b.camel@gmail.com>
	 <DII0TT9LXYCX.2GMM6QA4Q9BPZ@gmail.com>
	 <0fb2d99b-b122-44fa-a8bc-9befe6e350bc@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI2LTA1LTE1IGF0IDEyOjM0ICswODAwLCBLYWl0YW8gQ2hlbmcgd3JvdGU6Cj4K
PiDlnKggMjAyNi81LzE0IDA5OjUwLCBBbGV4ZWkgU3Rhcm92b2l0b3Yg5YaZ6YGTOgo+ID4gT24g
V2VkIE1heSAxMywgMjAyNiBhdCAzOjUzIFBNIFBEVCwgRWR1YXJkIFppbmdlcm1hbiB3cm90ZToK
PiA+ID4gT24gVHVlLCAyMDI2LTA1LTEyIGF0IDA2OjQxICswMDAwLCBib3QrYnBmLWNpQGtlcm5l
bC5vcmcgd3JvdGU6Cj4gPiA+Cj4gPiA+IFsuLi5dCj4gPiA+Cj4gPiA+ID4gV2hlbiBhIEJQRiBw
cm9ncmFtIGhvbGRzIGFuIG93bmluZyBvciByZWZjb3VudC1hY3F1aXJlZCByZWZlcmVuY2UgdG8K
PiA+ID4gPiBvbmUgb2YgdGhlc2Ugbm9kZXMgKG5vZGUgWCksIHdoaWNoIGlzIHN0cnVjdHVyYWxs
eSBzdXBwb3J0ZWQgYmVjYXVzZQo+ID4gPiA+IF9fYnBmX29ial9kcm9wX2ltcGwoKSB1c2VzIHJl
ZmNvdW50X2RlY19hbmRfdGVzdCgpIGFuZCBvbmx5IGZyZWVzIGF0Cj4gPiA+ID4gcmVmY291bnQg
MCwgYSBjb25jdXJyZW50IHB1c2ggdG8gYSBESUZGRVJFTlQgYnBmX2xpc3RfaGVhZCBiZWNvbWVz
IGEKPiA+ID4gPiBjb3JydXB0aW9uOgo+ID4gPiA+Cj4gPiA+ID4gQ1BVIDAgKGJwZl9saXN0X2hl
YWRfZnJlZSwgbG9jayByZWxlYXNlZCkgIENQVSAxIChCUEYgcHJvZywgcmVmY291bnQgWCkKPiA+
ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAgIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gPiAob3duZXIgb2YgWCA9PSBOVUxMLCBYIGxpbmtl
ZCBpbiBkcmFpbikKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnBmX2xp
c3RfcHVzaF9iYWNrKG90aGVyLCBYKQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgX19icGZfbGlzdF9hZGQ6IHNwaW5fbG9jaygpCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbXB4Y2hnKFgtPm93bmVyLCBOVUxMLAo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFBPSVNPTikg
LT4gT0sKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfYWRk
X3RhaWwoJlgtPmxpc3RfaGVhZCwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvdGhlcl9oZWFkKQo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC0+IG92ZXJ3cml0ZXMgWC0+bmV4
dCwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBY
LT5wcmV2LCBjb3JydXB0cwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoG90aGVyX2hlYWQncyBjaGFpbgo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJlY2F1c2UgWCBpcyBzdGlsbAo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0aXRjaGVkIGludG8g
ZHJhaW4KPiA+ID4gPiBwb3MgPSBkcmFpbi5uZXh0OyAgICAgIChtYXkgYmUgWCBvciBuZWlnaGJv
ciB1c2luZyBYJ3Mgc3RhbGUgbmV4dCkKPiA+ID4gPiBsaXN0X2RlbF9pbml0KHBvcyk7ICAgIHJl
YWRzIFgtPm5leHQvcHJldiBub3cgcG9pbnRpbmcgaW50byBvdGhlcl9oZWFkLAo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb3JydXB0cyBvdGhl
cl9oZWFkJ3MgbGlzdCBhbmQvb3IgZHJhaW4KPiA+ID4KPiA+ID4KPiA+ID4gS2FpdGFvLCB0aGlz
IHNjZW5hcmlvIHNlZW0gcGxhdXNpYmxlLCBjb3VsZCB5b3UgcGxlYXNlIGNvbW1lbnQgb24gaXQ/
Cj4gPgo+ID4gSSB0aGluayBib3QgaXMgY29ycmVjdC4KPiA+IFRoaXMgcGF0Y2ggbG9va3MgYnVn
Z3kuCj4gPiBJdCBzZWVtcyB0byBtZSBhbiBvcHRpbWl6YXRpb24gdGhhdCBicmVha3MgdGhlIGNv
bmN1cnJlbnQgbG9naWMuCj4gPiBNYXkgYmUganVzdCBkcm9wIHRoaXMgcGF0Y2ggYW5kIHJlb3Jk
ZXIgdGhlIG90aGVyIG9uZSwgc28gdGhhdCBib3QKPiA+IHNlZXMgbm9ub3duIHN1ZmZpeCBsb2dp
YyBmaXJzdC4KPgo+IFRoaXMgcGF0Y2ggaXMgc3RpbGwgbmVjZXNzYXJ5IGJlY2F1c2UgaXQgYWRk
cmVzc2VzIHRoZSBwcm9ibGVtIGRpc2N1c3NlZAo+IGluIHRoaXMgdGhyZWFkOgo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9ESDg0NkMwUDg4UVUuMTZZVDEySTFMWEJaTUBldHNhbGFwYXRp
cy5jb20vCj4KPiBUaGUgcGF0Y2ggZG9lcyBoYXZlIGEgYnVnLCBob3dldmVyLiBUbyBmaXggdGhl
IGlzc3VlcyB3ZSBhcmUgc2VlaW5nIG5vdywKPiBJIHByb3Bvc2UgdGhlIGFkZGl0aW9uYWwgY2hh
bmdlcyBiZWxvdyBhbmQgd291bGQgYXBwcmVjaWF0ZSBmZWVkYmFjay4KPgo+IC0tLSBhL2tlcm5l
bC9icGYvaGVscGVycy5jCj4gKysrIGIva2VybmVsL2JwZi9oZWxwZXJzLmMKPiBAQCAtMjI2Myw4
ICsyMjYzLDEwIEBAIHZvaWQgYnBmX2xpc3RfaGVhZF9mcmVlKGNvbnN0IHN0cnVjdCBidGZfZmll
bGQgKmZpZWxkLCB2b2lkICpsaXN0X2hlYWQsCj4gICAgICAgICBpZiAoIWhlYWQtPm5leHQgfHwg
bGlzdF9lbXB0eShoZWFkKSkKPiAgICAgICAgICAgICAgICAgZ290byB1bmxvY2s7Cj4gICAgICAg
ICBsaXN0X2Zvcl9lYWNoX3NhZmUocG9zLCBuLCBoZWFkKSB7Cj4gLSAgICAgICAgICAgICAgIFdS
SVRFX09OQ0UoY29udGFpbmVyX29mKHBvcywKPiAtICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgYnBmX2xpc3Rfbm9kZV9rZXJuLCBsaXN0X2hlYWQpLT5vd25lciwgTlVMTCk7Cj4gKyAgICAg
ICAgICAgICAgIHN0cnVjdCBicGZfbGlzdF9ub2RlX2tlcm4gKm5vZGU7Cj4gKwo+ICsgICAgICAg
ICAgICAgICBub2RlID0gY29udGFpbmVyX29mKHBvcywgc3RydWN0IGJwZl9saXN0X25vZGVfa2Vy
biwgbGlzdF9oZWFkKTsKPiArICAgICAgICAgICAgICAgV1JJVEVfT05DRShub2RlLT5vd25lciwg
QlBGX1BUUl9QT0lTT04pOwo+ICAgICAgICAgICAgICAgICBsaXN0X21vdmVfdGFpbChwb3MsICZk
cmFpbik7Cj4gICAgICAgICB9Cj4gIHVubG9jazoKPiBAQCAtMjI3Miw4ICsyMjc0LDEyIEBAIHZv
aWQgYnBmX2xpc3RfaGVhZF9mcmVlKGNvbnN0IHN0cnVjdCBidGZfZmllbGQgKmZpZWxkLCB2b2lk
ICpsaXN0X2hlYWQsCj4gICAgICAgICBfX2JwZl9zcGluX3VubG9ja19pcnFyZXN0b3JlKHNwaW5f
bG9jayk7Cj4KPiAgICAgICAgIHdoaWxlICghbGlzdF9lbXB0eSgmZHJhaW4pKSB7Cj4gKyAgICAg
ICAgICAgICAgIHN0cnVjdCBicGZfbGlzdF9ub2RlX2tlcm4gKm5vZGU7Cj4gKwo+ICAgICAgICAg
ICAgICAgICBwb3MgPSBkcmFpbi5uZXh0Owo+ICsgICAgICAgICAgICAgICBub2RlID0gY29udGFp
bmVyX29mKHBvcywgc3RydWN0IGJwZl9saXN0X25vZGVfa2VybiwgbGlzdF9oZWFkKTsKPiAgICAg
ICAgICAgICAgICAgbGlzdF9kZWxfaW5pdChwb3MpOwo+ICsgICAgICAgICAgICAgICBXUklURV9P
TkNFKG5vZGUtPm93bmVyLCBOVUxMKTsKCkkgdGhpbmsgdGhpcyBzdGlsbCBsZWF2ZXMgYSBzaG9y
dCByYWNlIHdpbmRvdyBvcGVuLgpXaHkgZG9lcyB0aGUgLm93bmVyIGhhcyBmaWVsZCB0byBiZSBO
VUxMPwpDYW4gdGhlIGxvZ2ljIHRoYXQgaW1wbGllcyBmb3IgaXQgdG8gYmUgTlVMTCBiZSBleHRl
bmRlZCB0byBhY2NlcHQKUE9JU09OIGFzIHdlbGw/Cgo+ICAgICAgICAgICAgICAgICAvKiBUaGUg
Y29udGFpbmVkIHR5cGUgY2FuIGFsc28gaGF2ZSByZXNvdXJjZXMsIGluY2x1ZGluZyBhCj4gICAg
ICAgICAgICAgICAgICAqIGJwZl9saXN0X2hlYWQgd2hpY2ggbmVlZHMgdG8gYmUgZnJlZWQuCj4g
ICAgICAgICAgICAgICAgICAqLwoKWy4uLl0K

