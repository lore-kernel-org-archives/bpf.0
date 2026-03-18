Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F492D8768
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855300; cv=none; b=rL/YZNv9cATuhEmzE9biTjDwvVTcK3tgvfcL28emCyy7GTCYtONVSqUonkeosuVfu5ugnEUANAg9ZcDnHQrK5phGz/caGMrRDVNcrhRZDwvXd04Y0IOJ3WGEW/Ur6dtahZsw3jbYn8kCa50nV517tJO36Seezc12JR20XkYsUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855300; c=relaxed/simple;
	bh=Xv4i/v9f+MkYwg24utoarBBSpf+sV2FRrmSw/rGJIAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5Vs5jFlAg///st2cf88cJk9bWMvv2qQu3XkzKOzJG30xV1Y5Mnr5V/oN8kRNfaN/vpJXIeFWxUb3to94xrXSkAZLw4t7pGzapFW5PqduYX+uIrPZsS1hNWqe9sYAOPnM25Bp4ePKos9EJPAgGbe9iL7oB41gn8nETdEfOWGSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgGVvVL0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgGVvVL0"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829928e512aso119770b3a.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773855299; x=1774460099; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xv4i/v9f+MkYwg24utoarBBSpf+sV2FRrmSw/rGJIAk=;
        b=BgGVvVL0EQgskDfbID9eduB8VPE4Rh7Se1ofdNqHTEKWSQtsIb+bG2keT359rEy7mT
         +PtM4KlvbpDkBGhqEUajfPFjSpQsdMzErrmilDJIceJfUBbFVpei8iSHeluFJhTts8e0
         k+vhx5HXxnDV5wi2hI5DFcq7SkOXiTuBJHImHqAO55q9WEUDcWkuj4PeaigTLyyDoHRh
         dCT90wuWd2YrGStm5uGP3SbKZvkpk5O5jS6d1ndo6IqcOcgzBaSHHODEGElFiKzqA1O6
         ArehKUOIGWUXNtR0/jMAhwHH7o8NCBcErztulVytHfFYUozkO/uTdW5HrqlSCukGrogE
         5R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855299; x=1774460099;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv4i/v9f+MkYwg24utoarBBSpf+sV2FRrmSw/rGJIAk=;
        b=jrY6BgEp6IV7NeIAjMQERe31hrPRh/v6IpAAmCQbP1e+kZe0NAmpC1o5/am8WgHUTO
         wrRRwWIBiMhJt/NqProDhmhbJYBwB/3g+GUeUTIfQCOO7w1SpTV2pbBhu3X+LENiMY+d
         kGREXUOvi+cJ9MKq1g7Jao6NdX7BhaF8AHy2Qjwu8RrB6euLvIjngdLyhvLdDMaxW1A2
         mbMmpBl3VmRWql6jPVJVNRu6M7Z/1Aa7QJ1mQwvN79SIhHLAYgCxEBl6NqDtMlzhjAQ1
         CGukdLFcRQysrH/KK1RTmgEzGAgR/k1AI8Vrcfd73j/6ZoBSNHvH2bTOxLPBLP7BhUKp
         EPqA==
X-Forwarded-Encrypted: i=1; AJvYcCXBDxjJPpVXZxEbMpJkIQzJ3mlCd82Uc5HDMhFkj5P10mUa40MdmbOY7x/3i2oCS/1/pAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnq/PIGrVnUe8w9Zg0Um4sJQGxD5w765L+aBNMEOgklQ0RnEDW
	xvajdtNxIZliMxiWC/oVhELq2iyEXTizv0SJLAuPpRY+C3bQ46pA7cQe
X-Gm-Gg: ATEYQzzAPKwklv+Q4CJkA2902wnsQ2OmnhhSshUhjjL2fF8RyjCkyAiwoB5PQf0d46j
	/4tz4tiMwRfV/gUY4iPWCbgxG74jyU4ZNDzNdvKU3MFcY41vD/+5QPYBFYx7iHLwAhyEwz8sSv/
	gfbTeKxWfXAZyuzLJlHC65J1ifYXWRYdGq44PArPqJZcAWNYY58liuColxffi39ictzNy1RtaRZ
	0cz3NF2K95TdVqZ3OAMoDvf6IpBk3VTzm+WK4k9HcwEwMm6jknlvrRwyFypzF/ABXU+R3NW4JrX
	9zlHRM+0uWIWw96aLuQXhZ3sXFMztf2ur7D5Gke+CQ5UvFTM3Hy502BeyyB2ED4y9GmEdXTXE+R
	k+quj+fm6Dff9fkHjBcQr1Q/EoK0URke0mDu5uHjBqtWOr1ORiyjtGYVZmtAyeLRxRysskktTQZ
	gRpypI9AFKVpHZf/gosLUQPQu9tl3N+z3RRitzdltrb5PdW2iMEDc=
X-Received: by 2002:a05:6a00:71c2:b0:829:8aa3:2ec6 with SMTP id d2e1a72fcca58-82a6ac37b00mr3160033b3a.10.1773855298716;
        Wed, 18 Mar 2026 10:34:58 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1869sm3930301b3a.40.2026.03.18.10.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:34:58 -0700 (PDT)
Message-ID: <b37c0ff9282c190cd789048ddc106f8462e4c97a.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 1/4] bpf: representation and basic
 operations on circular numbers
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, shung-hsi.yu@suse.com, 
	paul.chaignon@gmail.com, harishankar.vishwanathan@gmail.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Date: Wed, 18 Mar 2026 10:34:55 -0700
In-Reply-To: <7fc04fca0467c59969f8658f6955ba7ec3b76b7317a1d17cfa64bde7e3e87249@mail.kernel.org>
References: <20260318-cnum-sync-bounds-v1-1-1f2e455ea711@gmail.com>
	 <7fc04fca0467c59969f8658f6955ba7ec3b76b7317a1d17cfa64bde7e3e87249@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI2LTAzLTE4IGF0IDE3OjExICswMDAwLCBib3QrYnBmLWNpQGtlcm5lbC5vcmcg
d3JvdGU6Cj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9jbnVtLmMgYi9rZXJuZWwvYnBmL2Nu
dW0uYwo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZGE1
MGE0MGU3OWFjCj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi9rZXJuZWwvYnBmL2NudW0uYwo+
IAo+IFsgLi4uIF0KPiAKPiA+ICsvKgo+ID4gKyAqIFN1cHBvc2UgJ2EnIGFuZCAnYicgYXJlIGxh
aWQgb3V0IGFzIGZvbGxvd3M6Cj4gPiArICoKPiA+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA2NC1iaXQgbnVtYmVyIGF4aXMgLS0t
Pgo+ID4gKyAqCj4gPiArICogTioyXjMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIChOKzEpKjJeMzLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKE4rMikqMl4zMsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoTiszKSoyXjMyCj4gPiArICogfHwtLS0tLS18
LS0tfD09PT09fC0tLS0tLS18fC0tLS0tLS0tLS18PT09PT18LS0tLS0tLXx8LS0tLS0tLS0tLXw9
PT09PXwtLS0tfC0tfHwKPiA+ICsgKsKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgfDwgYiA+fMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8PCBiID58wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHw8IGIgPnzCoMKgwqAgfAo+ID4gKyAqwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqDCoMKgIHwKPiA+ICsgKsKgwqDCoMKgwqDCoMKgwqAgfDwtLSstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0gYSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tPnwKPiA+
ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8Cj4gPiArICrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfDwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSB0IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPnwKPiA+ICsgKgo+ID4gKyAqIEluIHN1Y2ggYSBjYXNlIGl0IGlzIHBvc3NpYmxlIHRv
IGluZmVyIGEgbW9yZSB0aWdodCByZXByZXNlbnRhdGlvbiB0Cj4gPiArICogc3VjaCB0aGF0IOKI
gCB2IOKIiCBhLCAodTMyKWEg4oiIIGI6IHYg4oiIIHQuCj4gPiArICovCj4gCj4gU2hvdWxkICh1
MzIpYSBiZSAodTMyKXYgaGVyZT/CoCBBcyB3cml0dGVuLCB0aGUgY29uZGl0aW9uICh1MzIpYSBk
b2VzCj4gbm90IGRlcGVuZCBvbiB2LCB3aGljaCBtYWtlcyB0aGUgcXVhbnRpZmllciB0cml2aWFs
LsKgIFRoZSBmdW5jdGlvbgo+IGNvbXB1dGVzIHRoZSB0aWdodGVzdCByYW5nZSB0IGNvbnRhaW5p
bmcgYWxsIHYgaW4gYSB3aG9zZSBsb3cgMzIgYml0cwo+IGZhbGwgaW4gYiwgc28gdGhlIHNwZWNp
ZmljYXRpb24gc2hvdWxkIHJlYWQ6Cj4gCj4gwqAgc3VjaCB0aGF0IOKIgCB2IOKIiCBhLCAodTMy
KXYg4oiIIGI6IHYg4oiIIHQuCgpZZXMsIGl0IHNob3VsZCBoYXZlIGJlZW4gKHUzMil2IOKIiCBi
IGFuZCB0aGF0J3Mgd2hhdCBjYm1jIHRlc3QgaXMKY2hlY2tpbmcuCg==

