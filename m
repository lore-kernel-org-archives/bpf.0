Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA438237D
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733060; cv=none; b=Cg+/si73UGG/fR/qtnHEdJ7r1PmdaUWuYOF8iZL1yt4AzcZP0X739YbL3+QZvVzdqOLUzLGg4K+1CGmi6uIRU4wmYp/h14lHs8gUYKZhxWC/07M21mmchIHM1NQBmZJTqyhavTUFcwwbYN35xYATt0N9k9zrmVtkjY30H2aixvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733060; c=relaxed/simple;
	bh=yo/QqEyBv6r0KEfB6JhNXuJFLEKJf6YiuY5wQi5XRbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TqE+xgVxD3HZW90EGnibYsnmgXFEP2kg06FdkSHM4m9qEs1B7TInaE62KqR7v53p6swzlJ3DwSAOpk6Zd3+HgL1SdP7RTE6N6KVQxaeFi+Jd7DjCvXoUqpD0eQ7A9bJ70jJgKNam0G4aOG6C6R1SoG29GOPMGRiqKMt02WkYfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fHJrWCPE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fHJrWCPE"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso3328076a12.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782733057; x=1783337857; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsUvbYZueAc+svWz2xljZ6btlooKMmGWQDBlphVR8PI=;
        b=fHJrWCPEDflCWJqWCINxcExeDvSf8oEWLt7yXNS2P+++dN4hmlegbEyroVlcWP57or
         3DDLV9skqw6LeyVNKv87lM9yz9Fm5/DpAaoj1TBTB5MNWfgPqSYHIt06Zm5ce8zwSkIE
         TV807rtj4hVbA7qHm8GE3Kcn61GNpl64fAb6GLk6DTQvNYL6RgTxrq5yG5jrcgSDYqS9
         7n7iPeKfoFw/bmmRjBvdhYuhIYTznmr2FI5F3CVMMmQR3jx8QSskZabYZ2d+EvOK90I6
         OV9WQeZQEbjsnlvr2dX2E8rMV3P2v+hMSNmCyOO8AK5iJn8lXiXaO7P1G3T35ttfnw2E
         WWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782733057; x=1783337857;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wsUvbYZueAc+svWz2xljZ6btlooKMmGWQDBlphVR8PI=;
        b=l8KsOeBEgxzYdP37A6jRVBI9OtVykSj/YPFB9f8Pe80x0pGFmK6Yb5cVxXzdIGM5Wn
         fWuFyIDMH82J7mghjbtqWQfKYO8K8yoEQ+rjN0/tMn3ZtjB3gbhTNowRAf1GvszSWC+i
         3j5AA23eYB2sYm9VbLlZmUSUT4biFoiLzzNePt2T/wrevxchYS1i5pSiprg3WvspjtJC
         nQYvO40VSs7L+tULwSf3REyluOXSSez+OtP/U1zLvMP8w3iRJyMvKtrX1gHScnPZZ3Mt
         hj5l26t/HaGGpNVrMmP9ohl9r2RDNttTtDPDhbp9I1d4pXJRHqhxuHciMPLeuBsaxBrI
         6Yew==
X-Forwarded-Encrypted: i=1; AHgh+RqDIO/XQm5/DibiEFA7pVW0sT2AmMQoDkEvXG7s/yIN+dbKh/H6QfrZQpMfsF7PprIsUQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMvk+cs7kgWDyKZVRWCDYDzW0Rh7wDe+NVMa5cZOMvA4F1tKR
	Icnl1T/WlY5W4gXaCWeQxuqgSPbXQ7hqHina9t2qBDXwSawoLfQIyVeQCkiBHruldgypsAptivm
	h/HE/+R8=
X-Gm-Gg: AfdE7cnUveevJ3v4hL1djQH1Nig1NvNyhXJG3kgOfAsgKZrDZ+Hwg1XT+rn9MRsfNfh
	U1hqU4AFe7pz36pKLJwnrxDKXQJbljeyT4bMpWT8avb916wOzbBrT0f8DwoBXlQjESoFAs09s6j
	MPmenEctAWnMSG0UpBeGx1AwOwtLc41aSb90tBqQa+0hxNSvCM4cMtOu/S5wWnZWkQNngAa63ze
	4mFH01apOQ0SQwNn5vSFIN/7uVjlmHmkf3TuoYL9RoTkv97+Fw7sckNR8WMGFn5TpyFRgbw5+g/
	UJ3aIZ24kPJBtTu/kZt9BZ2XEwvc7alE7QRGI4ud42hBDR2PNKMViAIw2/lGMRykvHPX8wUaVMW
	B2j5wwiYu/ddIcpGetbxE2onDEQw0Mz1sb6Jo6tzC9V/Fk0JrsRDFahqqRseMWlMXRtJGpW1rri
	Yv57QzYL3A2yoXR/g/QER9PNVPxg==
X-Received: by 2002:a05:6402:3415:b0:698:3e69:615f with SMTP id 4fb4d7f45d1cf-6983e697ddbmr3013953a12.4.1782733057478;
        Mon, 29 Jun 2026 04:37:37 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6986625efc1sm1527299a12.19.2026.06.29.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 04:37:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: sashiko-reviews@lists.linux.dev,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
In-Reply-To: <e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co> (Michal Luczaj's
	message of "Sun, 28 Jun 2026 23:59:37 +0200")
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
	<20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
	<20260626205814.BAC3C1F000E9@smtp.kernel.org>
	<e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 29 Jun 2026 13:37:34 +0200
Message-ID: <87v7b137cx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 28, 2026 at 11:59 PM +02, Michal Luczaj wrote:
> On 6/26/26 22:58, sashiko-bot@kernel.org wrote:
>> [Severity: High]
>> Could a memory ordering regression here allow unbound UDP sockets to still
>> bypass this check?
>> 
>> In udp_v4_get_port(), the flag and hash are set:
>> 
>> net/ipv4/udp.c:udp_v4_get_port() {
>>     ...
>>     sock_set_flag(sk, SOCK_RCU_FREE);
>>     sk_add_node_rcu(sk, &hslot->head);
>>     ...
>> }
>> 
>> Because these stores lack a memory barrier between them, could sk_hashed(sk)
>> return true on another CPU while SOCK_RCU_FREE is not yet visible, allowing
>> the leak to still trigger?
>
> I'd like to verify it on a weakly-ordered CPU; please give me a day or two.

False positive, IMO.
Both ->get_port and sock_map_sk_state_allowed run with sk_lock held.
