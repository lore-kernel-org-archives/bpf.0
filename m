Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506E4195B5
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621299; cv=none; b=gdyy99elCv2IMS23xtI+cWzIhiaoKDRqarr6+ez+q6j4P2ZXuqwwcUuq+XrOqV2QkfJtHBrMsAt+Ni5iFg2K8OHJjyUy1a+6KvA/IjHOIrZd15czac8KNRNBWfZL/ZdCwKHP4v8BhpuYM936ktmPMQ6LgyzCtojmDM0slG1znNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621299; c=relaxed/simple;
	bh=2ZFBMw0jXPvAlCWbt/XYS9TdxiyGJlZhpqwlYwwxzso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1HZ5JBCa8J8w8NY2rHcym+i3LbMseEk3448zEopw9x0a0H32vj2vf4/bdL4yWdvwYE/MljFCkDNyvwxvbXkgxRm76lUup6wYGaJestzfGiiFa0zsAQybPIjIjJmNQsbhDeMz5DdrUou1PL5oyrS3Mn5di4fBKpC085ezGKDUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiMyo3+H; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiMyo3+H"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso56549b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621297; x=1784226097; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2ZFBMw0jXPvAlCWbt/XYS9TdxiyGJlZhpqwlYwwxzso=;
        b=kiMyo3+HAz6gvxb7o8vyGf4yJFmfSU5vAIcXZ5EEHH4RLeStsn8p2dg2zGcUg5eL+I
         xpdKiEAkO4yCqKrwpbwvSvoIB4iDjWaiiieG5LCeAeWRT60TVEQ78Tdvbpf25r9dFPKb
         yASEExW3qT9sth4/1Qvj5t7xuqeXT6nY/XelSTPN51MW/NQ5S9D+TwQCH4rKsQcKkiAx
         lXJyU6Q4CouIv+BkrSFfpLp2Wr5r7nRVniI+32l9KojDepBON8zqjThjVM9jEHh5EIQH
         QKrPWUPqsuXlAegU/3OoD1ys9n6OuovOhgYM/kyHeU6tEecHguOh4oS4CvSbYOjBrG2N
         G+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621297; x=1784226097;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ZFBMw0jXPvAlCWbt/XYS9TdxiyGJlZhpqwlYwwxzso=;
        b=qoAk1O4nCPTI6I+KPE36HG6Hpf39//D1XqNdOgwLCwmcbL9vHMsP89LYbFVaf4mfDL
         z4X3ZdnGep5Yq/jcC9suSjararvYCgiX69YvKBVE4XxmL4UswpxFvoOY7hW6AUKyDwnZ
         LwVobhU9fxJYbJy6/USQ0Y2vMZr7bGvhPRsDd2AA7nHNApsTqlo18DyL2IZMeCBQqJoO
         EjwPHnwDnUZpEzxzpgE8zpRcT48fE/Pc05KdTKV4ZY3xLS/e9QEnCqQZhxhiuKuSJy50
         yWnZtDoCkBqX/HzqNTygqxWRNRWECFfeHvCyZvL+8hZnrqcqtu+/taCaqqKa4hOiyr4n
         BpSg==
X-Gm-Message-State: AOJu0YzRKlBq4IYW88FN/rgwNzkr3SK8QGZsQDk9xCOaoe4AAwqufB4I
	/HBAxvd4kSYf0NmNr7IqMZG9vhMx9erk11YWC5tEAJJTu//w1DJGhUO1
X-Gm-Gg: AfdE7cnan/+bQaPlh29tKoGFHfkVOJCKLjfs0ggFtpVRf9nv5vJIpT7LYKmQDvUKk6+
	VAm8T8T1jnbc9utmj6OZrFsFSqPvHG0oVq9JLwkxQ2XiKa6ZTLusYpSCEBFLkylwwuBg2riTkQL
	bAQEYfpV5oyQghW3J7wFR5CLKZNsjDimuCrJA8/kn9IHORq13IyoqCImWcspmqqky4QWrN+dGzz
	r/2wLlnPxnedrUyhjs7wi/hKgXDrA0MFog/mn2PlS47B1kHiRk4aiXng6hJBp0FCdR9D9zwO2aw
	CALRXFNrrZo8JYkxlheCsz6EbemC1PY5XjhqaHEBOyRuNFXNvwtJvCvqxx1z0+JyDy0Zu/l48mF
	S5tWo5AXvukrGG/Gd32wCO/kKY30N1rgo9MFQCFy+w0AdQs0hG/UTKeeFa0vgXExPhNk0adWJgf
	hlMrE/AWwiTIpgH7a79p2iPGNTMyeXzcRosEg6R7i2
X-Received: by 2002:a05:6a00:448b:b0:847:834d:b6a6 with SMTP id d2e1a72fcca58-84842fff014mr8407959b3a.62.1783621297198;
        Thu, 09 Jul 2026 11:21:37 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84856d5d619sm1690461b3a.39.2026.07.09.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:21:36 -0700 (PDT)
Message-ID: <1f8aad47f61fbf85eb55276e4bb01bfcff61393e.camel@gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for
 buffer pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, 	emil@etsalapatis.com, shuah@kernel.org, mmullins@fb.com,
 	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 09 Jul 2026 11:21:32 -0700
In-Reply-To: <ak8XSRiLKx5WcIQw@u94a>
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
	 <20260708090151.151729-2-sun.jian.kdev@gmail.com> <ak5HLLrYK3R_g2y_@u94a>
	 <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>
	 <ak8XSRiLKx5WcIQw@u94a>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI2LTA3LTA5IGF0IDE0OjQ3ICswODAwLCBTaHVuZy1Ic2kgWXUgd3JvdGU6Cj4g
T24gV2VkLCBKdWwgMDgsIDIwMjYgYXQgMTA6MTE6MDFQTSArMDgwMCwgc3VuIGppYW4gd3JvdGU6
Cj4gWy4uLl0KPiA+ID4gPiBAQCAtNTMyNiwxNCArNTMyNiwxOCBAQCBzdGF0aWMgaW50IGNoZWNr
X21heF9zdGFja19kZXB0aChzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52KQo+ID4gPiA+IMKg
c3RhdGljIGludCBfX2NoZWNrX2J1ZmZlcl9hY2Nlc3Moc3RydWN0IGJwZl92ZXJpZmllcl9lbnYg
KmVudiwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqYnVmX2luZm8sCj4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0
IHN0cnVjdCBicGZfcmVnX3N0YXRlICpyZWcsCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJnbm9fdCBhcmdubywgaW50
IG9mZiwgaW50IHNpemUpCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJnbm9fdCBhcmdubywgaW50IG9mZiwgaW50IHNp
emUsCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdTMyICphY2Nlc3NfZW5kKQo+ID4gPiA+IMKgewo+ID4gPiA+ICvCoMKg
wqDCoCBzNjQgc3RhcnQsIHZhcl9vZmY7Cj4gPiA+ID4gKwo+ID4gPiA+IMKgwqDCoMKgwqAgaWYg
KG9mZiA8IDApIHsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXJib3NlKGVu
diwKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiVz
IGludmFsaWQgJXMgYnVmZmVyIGFjY2Vzczogb2ZmPSVkLCBzaXplPSVkXG4iLAo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWdfYXJnX25hbWUoZW52
LCBhcmdubyksIGJ1Zl9pbmZvLCBvZmYsIHNpemUpOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRUFDQ0VTOwo+ID4gPiA+IMKgwqDCoMKgwqAgfQo+ID4gPiA+ICsK
PiA+ID4gPiDCoMKgwqDCoMKgIGlmICghdG51bV9pc19jb25zdChyZWctPnZhcl9vZmYpKSB7Cj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhciB0bl9idWZbNDhdOwo+ID4gPiA+
IAo+ID4gPiA+IEBAIC01MzQ0LDYgKzUzNDgsMjkgQEAgc3RhdGljIGludCBfX2NoZWNrX2J1ZmZl
cl9hY2Nlc3Moc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwKPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVBQ0NFUzsKPiA+ID4gPiDCoMKgwqDCoMKgIH0KPiA+
ID4gPiAKPiA+ID4gPiArwqDCoMKgwqAgdmFyX29mZiA9IChzNjQpcmVnLT52YXJfb2ZmLnZhbHVl
Owo+ID4gPiA+ICvCoMKgwqDCoCBpZiAodmFyX29mZiA+PSBCUEZfTUFYX1ZBUl9PRkYgfHwgdmFy
X29mZiA8PSAtQlBGX01BWF9WQVJfT0ZGKSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB2ZXJib3NlKGVudiwgIiVzICVzIGJ1ZmZlciBvZmZzZXQgJWxsZCBpcyBub3QgYWxsb3dl
ZFxuIiwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZWdfYXJnX25hbWUoZW52LCBhcmdubyksIGJ1Zl9pbmZvLCB2YXJfb2ZmKTsKPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUFDQ0VTOwo+ID4gPiA+ICvCoMKgwqDCoCB9
Cj4gPiA+ID4gKwo+ID4gPiA+ICvCoMKgwqDCoCBzdGFydCA9IHZhcl9vZmYgKyBvZmY7Cj4gPiA+
ID4gK8KgwqDCoMKgIGlmIChzdGFydCA8IDApIHsKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHZlcmJvc2UoZW52LAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICIlcyBpbnZhbGlkIG5lZ2F0aXZlICVzIGJ1ZmZlciBvZmZzZXQ6IG9mZj0l
ZCwgdmFyX29mZj0lbGxkXG4iLAo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJlZ19hcmdfbmFtZShlbnYsIGFyZ25vKSwgYnVmX2luZm8sIG9mZiwgdmFy
X29mZik7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVBQ0NFUzsK
PiA+ID4gPiArwqDCoMKgwqAgfQo+ID4gPiAKPiA+ID4gSSB3YXMgdGhpbmtpbmcgb2Ygc3VnZ2Vz
dCB0byBqdXN0IGRvIGEgc2luZ2xlIHVuc2lnbmVkIGNoZWNrCj4gPiA+IAo+ID4gPiDCoCB2YXJf
b2ZmID0gcmVnLT52YXJfb2ZmLnZhbHVlOwo+ID4gPiDCoCBpZiAodmFyX29mZiA+PSBCUEZfTUFY
X1ZBUl9PRkYpIHsKPiA+ID4gwqDCoMKgIC4uLgo+ID4gPiAKPiA+ID4gQnV0IGxvb2tpbmcgYXQg
dGhlIGNvZGUgYmVmb3JlIDAyMmFjMDc1MDg4Mywgd2hhdCB5b3UgaGF2ZSBpcyBjbG9zZXIKPiA+
ID4gYWxpZ25lZCB0byB0aGUgcHJldmlvdXMgYmVoYXZpb3IsIGxldCdzIHN0aWNrIHRvIHRoaXMu
Cj4gCj4gQWN0dWFsbHkgbG9va2luZyBhZ2FpbiBhdCAwMjJhYzA3NTA4ODMsIG1vdmluZyB0aGUg
YG9mZiA8IDBgIGFmdGVyCj4gdG51bV9pc19jb25zdCgpIGFuZCBicmluZ2luZyBiYWNrIHRoZSBg
b2ZmICs9IHJlZy0+b2ZmYCByZW1vdmVkIGZyb20KPiBjaGVja19tZW1fYWNjZXNzKCkgaXMgcGVy
aGFwcyB0aGUgbW9yZSBmYWl0aGZ1bCByZXN0b3JhdGlvbiBvZiB0aGUKPiBvcmlnaW5hbCBiZWhh
dmlvci4gCj4gCj4gVGhvdWdoIHJlZy0+b2ZmIG5vIGxvbmdlciBleGlzdHMsIHdlIGhhdmUgdG8g
dXNlIHJlZy0+dmFyX29mZi52YWx1ZQo+IGluc3RlYWQuIElJVUMgYW55IHJlZ2lzdGVyIG9mIHBv
aW50ZXIgdHlwZSBzaG91bGQgYWxyZWFkeSBoYXZlIGl0cwo+IHZhcl9vZmYgYm91bmRlZCB0byAr
LUJQRl9NQVhfVkFSX09GRiBieSBhZGp1c3RfcHRyX21pbl9tYXhfdmFscygpIGluCj4gdGhlb3J5
LCBhbmQgdGh1cyBzaG91bGRuJ3Qgb3ZlcmZsb3cgYGludCBvZmZgLgo+IAo+IFNlZSB0aGUgZGlm
ZiBiZWxvdy4KPiAKPiBbLi4uXQo+IAo+ID4gSSBhZ3JlZSB0aGF0IHRoZSBzaXplIGNoZWNrIGlz
IHJlZHVuZGFudCBnaXZlbiB0aGUgY3VycmVudCBjYWxsIHBhdGguIEnigJlsbCBsZWF2ZQo+ID4g
djQgYXMtaXMgZm9yIG5vdyB0byBhdm9pZCBhbm90aGVyIHJlc3BpbiB1bmxlc3MgbWFpbnRhaW5l
cnMgcHJlZmVyIGRyb3BwaW5nIGl0Cj4gPiBvciBhZGRpbmcgYSBzaG9ydCBjb21tZW50IGFyb3Vu
ZCB0aGUgYWNjZXNzX2VuZCBjYWxjdWxhdGlvbi4KPiAKPiBBZ3JlZSBhbmQgbWFrZSBzZW5zZS4g
TGV0J3Mgc2VlIHdoYXQgQEVkdWFyZCB0aGlua3MuCgpJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB0
aGlzIHBhdGNoIGlzIGF0dGVtcHRpbmcgdG8gZml4LgpJZiB5b3UgcnVuIHRoZSBzZWxmdGVzdHMg
ZnJvbSBwYXRjaCAjMiBhZ2FpbnN0IGN1cnJlbnQgYnBmLW5leHQgYm90aAp3b3VsZCBiZSByZWpl
Y3RlZC4gSWYgeW91IGV4dGVuZCB0aGVzZSB0ZXN0IGNhc2VzIHRvIGV4ZXJjaXNlIGEgdHJ1bHkK
bmVnYXRpdmUgb2Zmc2V0LCB0aGF0IHdvdWxkIGJlIHJlamVjdGVkIGFzIHdlbGwuCgpBbmQgdGhp
cyBkb2VzIG5vdCByZWx5IG9uIFVCLgpDb25zaWRlciB0aGUgY3VycmVudCBjb2RlOgoKCWVudi0+
cHJvZy0+YXV4LT5tYXhfdHBfYWNjZXNzID0gbWF4KHJlZy0+dmFyX29mZi52YWx1ZSArIG9mZiAr
IHNpemUsCgkJCQkJICAgIGVudi0+cHJvZy0+YXV4LT5tYXhfdHBfYWNjZXNzKTsKCgpUaGUgdHlw
ZXMgb2YgdGhlIGV4cHJlc3Npb25zIGludm9sdmVkOgoKICByZWctPnZhcl9vZmYudmFsdWUgKyBv
ZmYgKyBzaXplCiAgdTY0ICAgICAgICAgICAgICAgICAgaW50ICAgaW50CgpUaGUgcHJvbW90aW9u
L2NvbnZlcnNpb24gcnVsZXM6CgogIHU2NCArICh1NjQpKHM2NClpbnQgLT4gdTY0CgpJbiBvdGhl
ciB3b3JkcywgJ29mZicgYW5kICdzaXplJyB3b3VsZCBiZSBzaWduIGV4dGVuZGVkIHRvIHM2NCBh
bmQKdGhlbiB0cmVhdGVkIGFzIHU2NC4gSGVuY2UgYW55IG5lZ2F0aXZlIG9mZnNldCB3b3VsZCBi
ZSByZXByZXNlbnRlZAphcyBhIGxhcmdlIHVuc2lnbmVkIHZhbHVlIGluIG1heF90cF9hY2Nlc3Mu
CgpOb3csIHRoZSByZWFsIGhlYWQgc2NyYXRjaGVyIGlzIHdoZXRoZXIgdTY0IC0+IHUzMiB0cnVu
Y2F0aW9uIG9uIHRoZQphc3NpZ25tZW50IGNhbiBiaXRlIGhlcmUgKG1hc2sgaGlnaGVyIGJpdHMg
b2YgYSBiaWcgcG9zaXRpdmUgb3IKbmVnYXRpdmUgdmFsdWUpLiBHaXZlbiB0aGUgYm91bmRzIG9u
IHRoZSB2YWx1ZXMgaW52b2x2ZWQ6Ci0gcmVnLT52YXJfb2ZmLnZhbHVlIGlzIC0yKioyOS4uMioq
MjkKLSBvZmYgaXMgLTIqKjE2KzEuLjIqKjE2LTEKLSBzaXplIGlzIDEsIDIsIDQgb3IgOAoKSXQg
Y2Fubm90LgoKSWYgb25lIHdhbnRzIHRvIGJlIHRydWx5IHBhcmFub2lkLCBvbmUgY2FuIGFkZCBh
IHRydW5jYXRpb24gY2hlY2sKYmVmb3JlIHRoZSBhc3NpZ25tZW50LCBqdXN0IHRvIGF2b2lkIHRo
ZSBtZW50YWwgZ3ltbmFzdGljcy4KQnV0IHRoYXQgd29uJ3QgYmUgYSBmaXggZm9yIGFueSBvYnNl
cnZhYmxlIGJlaGF2aW91ci4KClsuLi5dCg==

