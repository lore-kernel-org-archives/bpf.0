Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609055;
	b=V7mFX6liB1MKxw5Sy1lSGUyFWdobL7EgAZ+1MXhDdd5CbpEXbiBqPd72od3wG5GPf99/
	 NhaNxc+u5ZZ5dq1GE3A6jSWsjGv2G9jRb8dMnUXb3+LID9/PDYTl3BO3T4Bcf/nD82kNn
	 fDaOG0BolcvA3gFzWbZS1RqJUr3/sUIk8R0iqVUySOxJ1oBunETsxuWg253qqQwQs4OhK
	 16+PL9GKaPDIBsIyLCdrqFwOkxG8Vkpf2NLT6e+8L/31Qcr/63CFipjmOlbsSs8BSjkyB
	 HPYE3gIep8WGyKcSbQYRve232HwWyrmziCXvU/lZ464b1Q8RXK8yHJveoffMxiIZF3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=BSxcanS/47zEsQsgnmEoyPzbIaTmGno0kzGDYzGw5hI=;
	b=efC6VYxSOIZ5LMUNYpB/0zj/ano2qcJbQc9Iq6DidmQumcRcf4SZDBLQOCnFGexeaUxY
	 AP0N4TnuPn5KKvnPmztrn0mo45gSbtNFDVf+ZwD3GS6DW5Vn2fNHPZs0GpeflUIpy7SnE
	 gu/FlFWOOUGh/AcxwpjawuQspEWUGktdaoqFynGsLEDJeRARp1xufE9TM5rpF7d1xZ5Cv
	 IIkkKgwqhNdPjkoIZPqSfSG7p/GdqxJb02hagkmyn1aKWVyoy+JAOttAoBy9duRpLnife
	 5Wh9WimxLSkmR9GScRwHl70lJOfZB4GlnfuGN4GdGjNBwkzclLHKZ+RKPYxR92hV9Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q3ME6fG5;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFED606A322
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AFED606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q3ME6fG5
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-156cbe59622so785739c88.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792609054; x=1793213854; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BSxcanS/47zEsQsgnmEoyPzbIaTmGno0kzGDYzGw5hI=;
        b=q3ME6fG5kkdKozji1OSVG5OjVgmM5AvX15wr1r+TfRJSJVl+J0bT6OhQggJWtOs35I
         dNj5sJvH06VGaHlLZa9BllLXi8+gR6hRXoQjYdKBRDRHdbJsi2i34Zl5RLHx45TNVE/A
         QfXTAfq/6HJeM8eQJ8sMm4EjYiSecoqPkfY5egKOzbCL8/hgq6nSnq67Pr7MgIr69NoG
         UXh6y5O9TafUQWT7dDX5p0ue2hQEOBojnEScwWoXe+V8KymhWZ6PVqD0H7+pLiud5Cai
         5Gi6OG6MSq5SQo1PI/0F7WMW4JSueGW8ewm0uxzM+4uSuOx111v8rvFhS3VnqE/DXqPg
         FfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609054; x=1793213854;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BSxcanS/47zEsQsgnmEoyPzbIaTmGno0kzGDYzGw5hI=;
        b=ajAwO2K85aYNYzC4UxMBu7AVvC8Lxtb2tFhWzdhcXLljDzBHDXdMTC8nafl7hrR/ls
         KdAGqyoAHfeV89E7euNJ59RyNB6P8s1kehndk8k9uaJ9lThk7FMpDYfWz/oNaxqqXZva
         /sETuyCM9qL9/sG6inG7Fec9DlKqTyde2+InLzdX3i2kjpXjFtZEDVo/8+4efnfT0NPN
         uD0MxnszxlKyp3dxnET2cJanFgp2azHw81kzf59ukww7d9dHUIRLyPq916Y1x+YON67Q
         NLLX4urhUos47iupGBOCKz7mO4cxpWDh/7zPanSqC/TsQRBaER1gTNjtvxl2NDTgiAWM
         Cjfg==
X-Gm-Message-State: AFq9FYL+n0Ee5TtzAGGd25dDnQjUvZ11Z7suhwTgq3Jq0EmkvRwdGtUi
	jK4/dDObOi/Bvnp0TsOaIZtXhLOBEOaMbR+s4Z8fhMZXqtUjaBQNAmWu1ar0YHUO
X-Gm-Gg: AYBFou0I7AhIS51OaYfBXsIY76chzJXjstb4xdtFSncOU+GtbQ0zdFvF2LwKY46AlOt
	4jBMdmYRkbcjZGddw/wv9r6lBsjuwLT5V8XRTQiXcl0Ht1+Bph7XIWZdcUlVC5Y9XdwMhYSGyRM
	w5qxPhlIqlQWEpYtr5wwTrxPaUNAxFCdt4jDXTZny8HtWlg4039Sh0Y1Hn2GX2KhwuNbQ6coZ4z
	wVViN4C9PaIVJRQAm/y/radZuLiImlCd+hq+XtdJOBPgreguLCVXPR2W8wSODGUZFXLB/ezuG1x
	LjvwgE2EUqOvcUnHk8wNuKkpKIJ7wuo2htUCUVVQPV2/+tdH9Y2ovcFvd2ldW4jEpNj3TsUrFFf
	sJEbzRvW+Ag7vv30sXyuv49V8mlwv8pnRsOQAHtLWHB/Qou+m251EclnlSD5bldEtblTFZx2Co6
	jMg3qDKTqLAYdabvBXw2ZMWbmYriEhf39lJpt8H07JnvTjVL6s+ZJHCa6PfogNatqyqOIPgu5nx
	+r7/QWSc8tX9vTJOdIMqFkWx4cVTsRiekzuiHyjdfOEL1Bpcys/b+a1ufMOz4p94sZQfRBWM4YP
	1sep015SwjN9oABhy8Rp8DiKW11XsrnYgaEqdg==
X-Received: by 2002:a05:7022:6ba6:b0:16a:1fa:58cb with SMTP id a92af1059eb24-190a051e33emr4444375c88.1.1792609054032;
        Wed, 21 Oct 2026 11:57:34 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1e74:b094:f745:1e3d? ([2620:10d:c090:500::4:90ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm19856438eec.26.2026.10.21.11.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:57:33 -0700 (PDT)
Message-ID: <1f2b435506da3c11cd69e2ce98073ac3aaa013a1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject pointer operands for 32-bit
 recurrences/latches
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, kernel-team@fb.com, yonghong.song@linux.dev, 
	memxor@gmail.com
Date: Wed, 21 Oct 2026 11:57:32 -0700
In-Reply-To: <20261021185609.607075-1-eddyz87@gmail.com>
References: <20261021185609.607075-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 11:56 -0700, Eduard Zingerman wrote:

Please let me know if this should target 'bpf' instead of 'bpf-next'
since 7.4 request was sent.
