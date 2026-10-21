Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551611;
	b=R+3f2O13vn6hDUMNG+Nm7m8g3atfL7CRGno55sE83agJgkYIagiik0XqCjClK4R5gwos
	 CIyyZGjOnl0YrSKlUJoTHT8SnosKgRkyDBSP57G//S0UEijDJ0xoEaXnQDvc/TkL/OtTx
	 DsQuBuaAwezh9RqzKqW57qUXnwDNRIe6tWsVqLiCY3os0gwm0ib2UbRNxxnoEzevh1PeB
	 RtU3zlDg1d/hJbSa/EIhQGxgWuO2HNtudQ5HyyiPLJty0+AaOiTWhQqjq0lBtlBjKygL6
	 12f8tqraY9ArdQG8y856aMfb2lGVB7PSnPYsFF2blQ+sCWzLeZDcfzoadDfKsfLgCLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=odoVy4PHyyHu7+w2et+fTKefs40eChZdvSs2ZlLln/E=;
	b=1E51hC21QQGrn/OoiGkHZsav1l7faxfG0dFOuE9R2NOwjnsJGvjI00pwOEZj/oIFVxcs
	 BWJRToOZxIMXyBusKue1SJJNW85EtRnG539o5HxCdnsI3W/1rUFZef8zGulfsAPCIlnzB
	 MnKDfh2EMswqfAhYWMNWsU9ZBXnYDW74cqz/VrYIAgTOIYVbeKMLPjSnjMW0NQgNWtbTQ
	 Zlurq0DxKSNVvxv94yqvLD4eSgDSH04E+trJBqOTyTCEc3kqPufSFxbpW3kzffbbA8Hi4
	 c4qkAv/SjJ9pPbMTV8bgm9hXMcKnDSdy6vnC5Xve/0T/Yz6wAmxtGQgnFoNq88noj7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HfvvgyqH;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E25A606A31F
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 03:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E25A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HfvvgyqH
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2dd76b1361dso1909365ad.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 20:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792551610; x=1793156410; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=odoVy4PHyyHu7+w2et+fTKefs40eChZdvSs2ZlLln/E=;
        b=HfvvgyqHOBpQ2bmkkUAHg4k83iHwpxarJ8OUPul7yshlsjMGE3TcZ1Pb6Sbh77Q2lY
         fJGRuFhg87QGxfk7NjH61OZifK6aRje5Gjdo0FZM+dXFhIrLLYo3mC9As6J0gHJGd2uL
         ZpV0Wdqwg2kcunTt9XG11EeuJD1aO/IY6i5wraaeW4AxcAVhNwVM1WHjtDOk/auXyY5q
         hxJGAJUCpLKFfnnDRxPNv0e9LYjyg/5aM+Z+hIuGbf6JTxNdLlesZxZHKd8KVJTcJLCf
         Twwvh0nrRS1Q2ItVhoPdMmQ2oDhxNPh9ObUlTpor48N7jI/hL5kjczcgE2QyvIHqgQic
         XinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551610; x=1793156410;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=odoVy4PHyyHu7+w2et+fTKefs40eChZdvSs2ZlLln/E=;
        b=mh9ciwjzH9798vtkFA9pOENxbcOTP/oQP5vtfzDv0CmSBpGg6jZa0L4FWKyf92pgmX
         xz02jsE25Cj0ve+eK3J/9o0LOEOWqQQlcqdVmrWURHVl7PhZ5oUuYvXnASPUFI12pfgj
         DfPVJFqwEnwUSIAIKIYPrKBNk7NNjWXQVwHoRlBqNRf9zUybGrIvbsIJqv6BdJkzoDIs
         fg/jg4uASmi1Ul3UpPHktFYBWurqHcEzJW0rph2AKqrjoh7xZbV1BXvBh3no0mhuyJoy
         vbLYvCfYBZ/+2f5xsmyk/kHuHuwsqFlEJYfMnu4cJ5eKNu6f25x/WgKQl5YeQEv37n3K
         LKBw==
X-Forwarded-Encrypted: i=1; AKwUvBz05L52EuT6uEkEjn2/w2wiHVwRvHLNqhytwknmrw/hPRZvGefnxUu1y+NMW7HZ4jokmXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrcVZKSK58Wmn6a/FfwnEVhLuLYa72bCTQlAg3VPsNJTDdvW6Z
	WJiIJd/Enn2gqRMUlQsiNdtjjEr6yJcUo606SI1wFYsVQiznYC5KxPIH
X-Gm-Gg: AYBFou1lbEWfEuX6Jx29JSv96C9ceD8o64C1yYymZhDmAj8L5GC+CXAgpBNW0VFrLjz
	ZkQ0kuqltaVQk6WYNE2Ty4DWLZS0NJGy8ie2SAP53h2spUfPcOvgr95xYqrZKGp4bkjwA1mi6ML
	7zkU/7eRl7o4S5GEmSWhYMaVpt40CWj81grmtwnlIsk6LugyBWT3H3jvzjJ9INMLhevjTkPGDQ3
	s3/GAEUtsOlMzo2Awy6gSTh/RaGCUKCLlTDhCBhGLqdgPe4otyird1+UGw4Cyywuh9u+oPhezaf
	EBj82jjo2CYCI94IkX88r7SoOlyekndRn/iDzJd9uifkyldTOjtIHBsIxrDB20E2kakJacb9gq7
	6+uC5+iFlimBAKstwVuMZ7VaIyk1wTscOUKHYtInlBu3bFPA+cgKQDaFegqxJ/yK/GqASS56bzF
	ZZ26B7NNGD2Ib1QNn1eCReoOuMcG6GA/U13hZyxCd+ocHDvnbmnKwPoSIC6Iu7ZVcE/WwTxMduf
	fAaV9KVz+bj+gOFG1K+jo5Jr19wsuNr3yFS48ZvliMDiwybw2PxOQDzaxGO/mYG+4JnKCYHNpJ2
	dvGuk7v6PMpDASRZt88uobORpsBiIQiNqFWukJn97/lizXcrOLnCvOM1hCChfE7R0fk4ih7Fdtl
	WSSIG5Kk=
X-Received: by 2002:a17:903:26c4:b0:2e9:7719:4104 with SMTP id d9443c01a7336-2ea4396ca12mr6207395ad.8.1792551610224;
        Tue, 20 Oct 2026 20:00:10 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b41096bsm5236935ad.26.2026.10.20.20.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 20:00:09 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 03:00:09 +0000
Message-Id: <DMA6IGX5XTOI.1DVKS3WN0K6NQ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <josef@toxicpanda.com>, <mason@kernel.org>, <steffen.klassert@secunet.com>,
 <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails
 late
In-Reply-To: <20261020192044.7c3a58a1@kernel.org>
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com> <20261020192044.7c3a58a1@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Tue, Oct 20, 2026 at 07:20 PM Jakub Kicinski <kuba@kernel.org> wrote:
> On Sat, 17 Oct 2026 01:39:12 +0000 Alexei Starovoitov wrote:
>> -	if (bpf_sk_storage_clone(sk, newsk))
>> +	if (bpf_sk_storage_clone(sk, newsk)) {
>> +		xfrm_sk_free_policy(newsk);
>>  		goto free;
>> +	}
>
> why not add a new jump target and add the unwind at the end
> of the function?

Don't care. Fix it yourself then.
