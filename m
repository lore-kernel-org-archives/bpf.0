Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421A35F197
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045686; cv=none; b=JrfWVDAvoRt1SR5gppDJ1h1plrb1+C96YF1ly0he8pjoUFppHRt4pDNWpGAfekSB+i6lBmodQrTtcSMvHHu4xy+IVTad5KsqfTNHeGLwYZAP121Yixq44MbtSmETU+AEjyq1TMhkUtY/ReAaajtyBvzJ/7HRRYlyqa2QY04B1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045686; c=relaxed/simple;
	bh=aeyTWcs9E+uxhD5i9by9Aiw1/t/1P3Hmw+3P//Rf/j0=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=ZgUJtQVp1wM/8+6ZHQ9b4+4HKp2+iDZFXxgK89qRP3YzykXiVYo4eD4C0zlaw+z5xdbGehmFIalLTTmeChlX0uLAjHbYoGq60V1DzbTq658G3x6PU1CHYG6IMIDLAxTXYQwzsZAWwkpLfaWqGeK5qqwV/6ex0KAsnzk1Uc7MEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ33fB5D; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ33fB5D"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso2676251a91.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790045674; x=1790650474; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrryUBh0wA9y45vzn1E+3pGPW3cTDea6KxpezXzlJsE=;
        b=AJ33fB5DUhWURYz6SWNtaULDCv19R4WGFQbH+NitcCD7qnu7Xe+kVPXTTHWDH9NlGz
         dEQ+26/+RHu+2ouMXluT0WOmGATmaZerl6YH6fSM9P3Gj/gGYGOuni69ppqRpDosX6Xu
         4elXOYxKkDdGw+3NWQSdez2tDMKjLfuIQKen2dyRBEfkw8Bo6NoKdcoZQyYS7vhrYEDA
         GA5nx4cQA3Cw1Syn/QRXJke/pqj4CS8pziaLZExdX2FLZ+ecNqKwexraaCQqzyW1eTrf
         YXlB+tnwIfS0E5uyfqAqrndXAtO5EsfQJmBYesYzgWFf6WEyDqQpT8crDmfXFHM1EWdn
         /w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045674; x=1790650474;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrryUBh0wA9y45vzn1E+3pGPW3cTDea6KxpezXzlJsE=;
        b=PpIrqnRByawrQ8SteXMbXyUg2rSHS/loypP5G0sAqIm5jQxCVkYqO8G1lBfoz+HsyQ
         1fjGrAmv+TdAsQiTURK5755dA1gMNDP0dICh6P/wT3YN7DFH0XEQURCh0Txa7SLxuVvM
         F2fgMGurM0VkiUYUiSmNFWl/OxipVRZ92kDhUc2xF3OrVT/8EG1XpzQHeStD5Y9amTv/
         supxpQgp94OsPT+jvUJxwogN0YDmk8MRiNP++nZKU5YK3zEpNfQKGZuYrBd9DHiD6/Ii
         Q63m7wCarUB4IsTIxiniry2ViMUkhDqnILbVvAOpD3jmBoSEQmvdg/pCgTqRhmStWnVt
         Uo3w==
X-Gm-Message-State: AFuF++kMUI5FKKZpmRIT8cB5saKM3cn9WkajMesiZYXCqt0nYyyy79AU
	2cuSLhqb8GfVUeWdpqz/KlT5feFleljDicsnunSeUHZH0lIyizxlPSd8
X-Gm-Gg: AYBFou0irlaLu01S9U05XHRy34J7k3s2GneiAPDKbDg9f1I+Q+lw+1rUMcEPTY0LdoK
	/GRNOD5K3YUNkwG352HqLV9Qc98hku1afJa371IiKtY5I2q5r9IneGuMVgu8tBoKgUUSmvIReur
	sde85Ft+6mq5pwAUxhJBDGBcSROMqrXTjMGRwZT6cQAX1i3ZR1Au5pWomWPqsbzUxXn2BwB1p06
	alljHuf8lAernEldvq3jNT26Oqvmbg4s7T1RaSjl6gtOEczv2S7IwmdqfY8DRtoajuEJSTzBFhv
	xArXzVspW6QeN2DwUU/frGeViT9t6hYRR2QDgGZ9OsLeSt6s95+v+e+8ZvDOqFcrxzDJqOQARz2
	F7wDgZUjeWrw0PzaQmiMxbLVzh0/KyFxiuaDaf9TJLDYX4ggq4z64IzmdFUUMMiywTYd1qPNgCC
	DGqquFVLGhoL0F5t3o1IP46PdqnZWmv4wUU3qmqcD7piJJJsKdTMme9VMPHMy2J7JpkBuGT4HnO
	3p2QYHlgt60ZYyv3a6e/NOl8PHyUQ4d+Qve3K58ol1mVzCw8isUb5WkgcOTuVvEmNzWCIg/+/2Y
	AjA=
X-Received: by 2002:a17:90b:3e85:b0:39e:3baa:bd3a with SMTP id 98e67ed59e1d1-39e54dca2fbmr18001286a91.12.1790045674245;
        Mon, 21 Sep 2026 19:54:34 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb2b46csm303914a91.3.2026.09.21.19.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 19:54:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 02:54:33 +0000
Message-Id: <DLLI8DZ44BSN.35MO12IZJET8H@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 06/17] bpf: Add callx calls to the call graph
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260922012711.C2F581F000FF@smtp.kernel.org>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com> <20260922011323.1298619-7-alexei.starovoitov@gmail.com> <20260922012711.C2F581F000FF@smtp.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 01:27 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +		if (bpf_is_callx(insn + i)) {
>> +			/*
>> +			 * Walk the callees recorded by the main verification
>> +			 * pass one by one, returning to this insn after each.
>> +			 */
>> +			if (dinfo[idx].callx_insn != i) {
>> +				dinfo[idx].callx_insn = i;
>> +				dinfo[idx].callx_next = 0;
>> +			}
>> +			sidx = next_callx_callee(env, idx, dinfo[idx].callx_next);
>
> [Severity: High]
> Could this lead to a quadratic path explosion and unbounded CPU time in the
> verifier?
>
> The callx_edges bitmap appears to aggregate all distinct callees for an
> entire caller subprogram. If I am reading this correctly,
> check_max_stack_depth_subprog iterates over this entire aggregate bitmap
> for every single callx instruction in that subprogram.
>
> If a subprogram has K callx instructions and M distinct callees, would the
> verifier evaluate K * M edges here instead of just K edges? Across nested
> subprogram calls, it seems like this combinatorial amplification could
> evaluate paths exponentially. Since this pass lacks state pruning or
> complexity bounds, could this bypass the verifier complexity limits and hang
> the kernel thread?

Not a bug. K * M is intentional. The edges are recorded per caller,
not per insn.
