Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197051;
	b=tYytg1NkK4dw5OA4eREGbRtpJt0cddlmH26pm1ep7VAia6VHZFrTX2j8s1ET9jAN/RXL
	 d3ONR6HwzJt6yQW0lC4MYx6CEGrMEE+W25xNOLGmvJbL8ZcWWHrB/PXyYf4rvOMTqLEUr
	 +vwQ0Hq6c0p3+2boE25mfXFHSOXiep15WTJMju6slra7nSMqcejjlRKQBi0UIn7hHmn8z
	 gFhxgu8j4YfnONKNZvKHLx9LhhV97gdXTM2Qe3AY1whw7JKYk2eg476O1ThCXa1e5fXt6
	 x8aNcdoaApIsyiNLRTaPpczZA3C8v3EqthiDL1FZezbbP1kWw6nrX0576W3Tbq5nl4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/ckA76GFethZlS9qiSTr1nMW1OVkHUs1BNcHEyirqeU=;
	b=FpAdr+FMMZH4besg4MtXVVD7mjoyWXcUNsLiyVrBhOp7bKZGwXj9hwr8TJMPAmgFMTUM
	 l1rrKD5fMDnmn13J+TKIf4iaBU3d/GFJI5KqNwHhtiMb2ZAZEk/b9hHqLkc6YVpNOcXEQ
	 ze73sa+WcYLjebKeCXHMlRh+q0wlGOP6e9HL21m0VcasOZ0/Goq2McxhREChiozBDsAwm
	 rmmqekJzVzz8DmFYN/ng371aT+NL6iqW+uLiJJtLyZIWwloAMJBIosA+qk9DtXlC1qxZT
	 g3NnFy29OUGedolrEhVObj0dMkw7pGEDzeItgRZIBhNC+ML57xomQThOfMzsrDq18cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EmaL/SoM";
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFED606A332
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 17:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FFED606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EmaL/SoM
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so617499a91.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 09:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197049; x=1795801849; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ckA76GFethZlS9qiSTr1nMW1OVkHUs1BNcHEyirqeU=;
        b=EmaL/SoMMd81bUJKpg0uUMpISoVj1BImflpsF++ClpRp4PBU9CRKlHP+4rifWn7cH2
         51lJMAi/nPqve2cebv8hACFV4u8uG/8yow28o+ZH+dtljZbjyrHENnbxriFZXF2eNU5t
         AlKL5U1j+NkIum5J0CtOfVwVdNnbDTGc9GgfX2HhAZnFKyidfk7fSU/nctU12GH7OSvW
         +ahqadBkDzAej4JUk5PbtQY5k2Q9hJeGLNvRqecH8GV5Y8X/6NPi665otLRGXWaVyRZG
         OplU55x6+F4j6peeIl7lgUu8zGRscNSXqf9w+iT0dOH1BryeHtl33UA0AQeMNVwSzY33
         9egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197049; x=1795801849;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ckA76GFethZlS9qiSTr1nMW1OVkHUs1BNcHEyirqeU=;
        b=u1Ggmt603mRzl8G4BvyFB4TSIH8oR5yy6K2JzyNqnowORxe/BhQU+frPFq94Z1C0Ck
         YECBJibvZLdymmatEtAF181QBgTMGIUBJDWTiENqRUR7zn2RcxxSiGQDab2UKCrBcMBR
         UyeRmIbw2YREQAcg0ZpFVlkRrybmgu2MF0946YOXT7kC+PQzkhj5Snv4RJ1O94XaFIZe
         J7ZqtYJoWDycPWFIr1VlhNMKLEh4zbxXaHjUnxlpoEyxPWEFIlke67M6uLIWk3QMTcv6
         YHpoA6OVRfgtAoa9k/kWT8DyUaD/FbUhFKKy0c5Dg13JDLFUuKjJBAh4Y0FohuwE/Kit
         ZJuQ==
X-Forwarded-Encrypted: i=1; AL+hErHDdag/GNlEuAETC8cJYlv0ZgWu5MH+Z2QA4KAbm2I6JzbpnEswuDRV4qL8Jwuka2FQyjk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m55V4SUF9+sc7AKcHW1Av9h+LLUBybflDRHPD2ZcH0eaalRo3
	j1BRZIIpTDQrayK2qKLWrshR1IypZPMbQk1qBBKWte+cPfudanFEeSIY
X-Gm-Gg: AZFdTZePL1k1F/01Izvdre7N8GmIM71ExGSTM/ll367TZ13ScFjZBmALWGY2gZvvmxr
	zy6QhyuLVBVj6Zd2QyS4km8OQePWGG9m95r4a2AamAAOdaL3QUQRUF5XmFCj+A3/Z6j+bNsoMVJ
	I1+rnU+KeoW7jNiLOb6DBe/VQXpF5ixMBnu67J+Kc29KmFSAgj+6Jt1VFomfdRdpjIjVSLe9Wn/
	mygMV+CYp75+dORu5rnoDGwK5Y9VDfiYsLkpZAQMkRgaYWTSUVIyJuCR8aR1NF+cZ5VWC9X3I6q
	R+9LDuvJZP+WZiUdn57WL/zmUbxDx+O8wTWh0iq0P+at94IsT/EcoqBUQd/1Ekfv2ZTK9xukA5B
	n8+CeJ3ZNSE79Tqepkqj22IFDeoIT/zzmA0/MI9AzOmzlQgYyDg2KVWlef4oi0z6lBWefoZzCDa
	dRVhVEmAWS+c0xNuPZ+r3bE07FBwh8y8kqkINxyamDJQyXWfmbwbuNdBsFsu0jybTLMBH1qbM95
	oblAp74jrk52+RJWg/OWnQ7FH9l11NJXZUBZMSOme0heE9GL3PpM0KF1WWVYfwmqNlTw9+eUzFM
	c8TZMfo9rMqeTGziqoUOO7a+fYm5U/q61BFzxq/GdG8v0EatbGaq46EBrv1G4EVSf8P1AUjQkrO
	3Kcm4GxwnAblzO9npiLAZl1vhE0ggb7PzWA==
X-Received: by 2002:a17:90b:4c4e:b0:3b4:d22:85fa with SMTP id 98e67ed59e1d1-3b41c98a150mr3371920a91.14.1795197048356;
        Fri, 20 Nov 2026 09:50:48 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm7924274a91.7.2026.11.20.09.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 09:50:47 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 17:50:47 +0000
Message-Id: <DN088QK5C3RO.26A4S236XCPSF@gmail.com>
Subject: Re: [PATCH bpf-next 05/49] bpf: Limit the cost and the memory of a
 load
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-224673@kernel.org>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com> <20261120074430.2704488-6-alexei.starovoitov@gmail.com> <sashiko-outbox-224673@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 20, 2026 at 12:00 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> @@ -22013,7 +22035,7 @@ static void free_states(struct bpf_verifier_env *env)
>>  {
>>  	struct bpf_verifier_stack_elem *elem;
>>
>> -	bpf_free_verifier_state(env->cur_state, true);
>> +	bpf_free_verifier_state(env, env->cur_state, true);
>>  	env->cur_state = NULL;
>>  	while ((elem = env->head)) {
>>  		env->head = elem->next;
>
> [Severity: High]
> Does the second bpf_free_verifier_state() call in free_states() also need
> env passed as its first argument?  Leaving it at two arguments breaks the
> build until commit "bpf: Put a barrier where no mask fits" replaces the
> loop later in the series:

It's already explained in the cover letter.
The kernel does not build after patches 3 .. 36.
Each line of code changes in one patch only. Patch 11 moves this loop
to free_pushed_states() and adds env there.
