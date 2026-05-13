Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9D37DE85
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712845; cv=none; b=deL9oVPZHRcowNGDe/wO4b5tbK0KAUJkrNBalRY9gHz89G73Sfqszjo/4V5PvQNN7ksOtJmqZvfp8sj6Sw6vcPnLexWRpC+0ClHVw9nRgRTO4akLBsu2mSj19WJcNNZx8bcs1M6UF+Is+xLj2mP6Rjp40HFLfaYjHk4geXTEdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712845; c=relaxed/simple;
	bh=aa6l7b+APFWz/5UdNV5Q7GOrbwD0gYuiQ9o7noutUhg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/17AHA6fqpdTNuEW0ycguDPe9pg42dehT7JGqZAjv/lSjxXJFCtxQXisAID3hDAI9EJsVowD88yoAcgES8sDoTIV6/gRS0N2ATPimiZG+yZeAqZl7Ed2yJoZeZSbRnQHYr85xUsRmBdm7LLdQ79VPoakpkjNQHuYnrVvuQjzn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Ybhon5; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Ybhon5"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1329fc4bf77so5675528c88.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778712843; x=1779317643; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aa6l7b+APFWz/5UdNV5Q7GOrbwD0gYuiQ9o7noutUhg=;
        b=j8Ybhon50iNTQHN4Xu4aOCf5VI+NTxIWF/q7L8EbUVy3HOBjoLyTBJEqO88GVGMrS3
         JuXDV9Dc1YyN4h/dG/GOFXxxYSEAYT7joGGWrOzpuhlcKxm5kK6bdr6VqLwpEE+Z6eVd
         6iCk0xcITCCQjBi6xsSXVNOb6Ortr+b2kqPOWLyEDr/AMzvm5LRfQC7Gc3JzavEyJkrg
         iPg/JM9xkTc6y271uIZF1dlG9A6nV5Ph0vEhgwHE6LNNvY/dElEt4OS4W1VF/zb3A0LF
         oGhUIF+wUFbIcztygZYeaRUY5cWTYywDVSwiMyWifPtZNPZD16H+vegaaQIQG+ODeeBf
         QWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712843; x=1779317643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa6l7b+APFWz/5UdNV5Q7GOrbwD0gYuiQ9o7noutUhg=;
        b=pWJrqA+wUfhxstlA2V5J37oASw0BC1T57FARYy2INPCh/uLpcPtBpJLxMpSjOgRPRv
         q+aly5oRrKm68rPspSN6hDPHdBp2hm+xUWvqgCuC6m673vW6O9JkjGKdWGT8UCz5iTUd
         a3PJDTzv5TZE9dqjXVn2Oe0SrIRwS7gkOtOzwuM1YCCJQqkI0oIbfZV307e4JZ7GpY1+
         S6jHr99mQImlrBB1vqqsBkVr0Hd1txIsE3rAMGcO8KUixntUDgEDCyD851Pv6Ttjy7df
         21h8zMNnX6SmuEc/GjWO1ANvBQOL1j2Oyx6tra2tLVOwNq5y1Lp+PeVPfcZmlpFJnvyE
         baVQ==
X-Gm-Message-State: AOJu0Ywv5MXqlqnLkbZEK+4tnZ0Gv52vHvI2ZZpySxQ5+N7Q/ENj/OGN
	eSl84feNgNKzWPcBp9y7ZLDQ4NoZR4r6ovoHMPO/rdwHIc+byIXOCDJW
X-Gm-Gg: Acq92OFDnB6bJ64n6CWmEjrI0nae9OapNjA88upW4FGE1Omum39vRcA/iv3ajXlK7+M
	R8jTFWgMYevi9KTE9jGqHZ2B8oK+k5pLB89TwX2/4Kqno5BowjQAAsVm5x1sRzWv6QQRRaTqHNs
	cu6k6GdwjjBTyCvzw3hpiuX5vcHmM21gw1bSmqQsodd2gyYEZvZMe6yUDXWjuc/RYVaD7emxAlA
	CFycV5k58WbVnJ3BMc8h76lj7o8uGSd4E9E7y1vN57vFuGpFfN9wjKU8ZYxltf83J+RXNmwfLLZ
	yScNPqH/nNQEtEUbUTsRM41kNiXqY4BSdhdny+XmAhNQ2aipspBjmQQ1ZFWONuGla56j/8HW5c5
	bSk7vTgw6D0gCfKaKoLPC5bfDBBASOs5MemWIhmd5d+B0k5BJA+tn6QbLzj7ZbypSryV80D2BFL
	g8pblocl6wOtym4aanUFhUkmsT5SDXYwzp5tuP5aVjozkANfBF9MJxQpVxiayb+DMPrPHADbep4
	LRjwW8=
X-Received: by 2002:a05:7022:6611:b0:12d:de3e:cc02 with SMTP id a92af1059eb24-13436bb037cmr3404126c88.41.1778712843089;
        Wed, 13 May 2026 15:54:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed531esm1473485c88.8.2026.05.13.15.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:54:02 -0700 (PDT)
Message-ID: <e141699dab70282d811ec30bbf2aa8279706817b.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and
 unlink before drop
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, kaitao.cheng@linux.dev, ast@kernel.org,
 corbet@lwn.net, 	martin.lau@linux.dev, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, 	yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, 	sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, skhan@linuxfoundation.org, memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org, 	martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 15:53:59 -0700
In-Reply-To: <da95f45b43d94d17796b19abc4c555e35daafab7d5e1cdca3714fe0f54ab8cce@mail.kernel.org>
References: <20260512055919.95716-3-kaitao.cheng@linux.dev>
	 <da95f45b43d94d17796b19abc4c555e35daafab7d5e1cdca3714fe0f54ab8cce@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDA2OjQxICswMDAwLCBib3QrYnBmLWNpQGtlcm5lbC5vcmcg
d3JvdGU6CgpbLi4uXQoKPiBXaGVuIGEgQlBGIHByb2dyYW0gaG9sZHMgYW4gb3duaW5nIG9yIHJl
ZmNvdW50LWFjcXVpcmVkIHJlZmVyZW5jZSB0bwo+IG9uZSBvZiB0aGVzZSBub2RlcyAobm9kZSBY
KSwgd2hpY2ggaXMgc3RydWN0dXJhbGx5IHN1cHBvcnRlZCBiZWNhdXNlCj4gX19icGZfb2JqX2Ry
b3BfaW1wbCgpIHVzZXMgcmVmY291bnRfZGVjX2FuZF90ZXN0KCkgYW5kIG9ubHkgZnJlZXMgYXQK
PiByZWZjb3VudCAwLCBhIGNvbmN1cnJlbnQgcHVzaCB0byBhIERJRkZFUkVOVCBicGZfbGlzdF9o
ZWFkIGJlY29tZXMgYQo+IGNvcnJ1cHRpb246Cj4gCj4gQ1BVIDAgKGJwZl9saXN0X2hlYWRfZnJl
ZSwgbG9jayByZWxlYXNlZCkgIENQVSAxIChCUEYgcHJvZywgcmVmY291bnQgWCkKPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAgIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiAob3duZXIgb2YgWCA9PSBOVUxMLCBYIGxpbmtlZCBpbiBkcmFpbikKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnBmX2xpc3RfcHVzaF9iYWNrKG90aGVyLCBYKQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19icGZfbGlzdF9hZGQ6IHNwaW5f
bG9jaygpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbXB4Y2hnKFgtPm93
bmVyLCBOVUxMLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoFBPSVNPTikgLT4gT0sKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGxpc3RfYWRkX3RhaWwoJlgtPmxpc3RfaGVhZCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvdGhlcl9oZWFkKQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC0+IG92ZXJ3cml0ZXMgWC0+bmV4dCwK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBYLT5wcmV2LCBj
b3JydXB0cwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG90
aGVyX2hlYWQncyBjaGFpbgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJlY2F1c2UgWCBpcyBzdGlsbAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHN0aXRjaGVkIGludG8gZHJhaW4KPiBwb3MgPSBkcmFpbi5uZXh0OyAg
ICAgIChtYXkgYmUgWCBvciBuZWlnaGJvciB1c2luZyBYJ3Mgc3RhbGUgbmV4dCkKPiBsaXN0X2Rl
bF9pbml0KHBvcyk7ICAgIHJlYWRzIFgtPm5leHQvcHJldiBub3cgcG9pbnRpbmcgaW50byBvdGhl
cl9oZWFkLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
b3JydXB0cyBvdGhlcl9oZWFkJ3MgbGlzdCBhbmQvb3IgZHJhaW4KCgpLYWl0YW8sIHRoaXMgc2Nl
bmFyaW8gc2VlbSBwbGF1c2libGUsIGNvdWxkIHlvdSBwbGVhc2UgY29tbWVudCBvbiBpdD8KClsu
Li5dCg==

