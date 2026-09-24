Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA341D23A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790273362; cv=none; b=q52JZDtpUryTJYyFNZ36a9H8f7v9sCvhw1IstCXk9WbEFbr4+3uIWdzlV/FTYJeH/mNCGgelr7QB/UzjWXwuR/0/z4HJgLEZe1CkFrGoECUqDD5ylarpJm4uIOVHaFVz9SMkvHoS8gwJUpDXJHcLeR0ZWzmXoy3BucHsnEKbPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790273362; c=relaxed/simple;
	bh=7zzTKYag8rFvtoQliIu5k91VjF4lYEuY/yJzMWXTrAw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=OqCdFpKDDJQXwwhre/O08FfSmqYtXeHauMgMXdh3FwDYJmmhzUkT5t4YViTqmcIGoXjK8DuS3qiICv7EW0jioLLKtpXDyis2fIkoGXc4Sm1NyCW9G/sFyMOk2Z11U4KgVdB2HoO+6MlwKfzZWULT6bAvJ9vCqDcdRUHEMU5Ds3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwZg6KuW; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwZg6KuW"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f9bso216135ad.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790273360; x=1790878160; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFYBwgGLU7KRklqsfMrMxCRpg6dqYI7jhCcLu+nG99s=;
        b=FwZg6KuWJdmkMVBVWZc1nfiNZVrbcMEbClJNoHO49zqspQwJlLwgfFBCmjXX2EMAca
         PvkVY3HcjZMoLfD4Be8L6kNRWdHXwQ73/z/lYtQUEywwpnha4d3dh1hSm8mu7doZvt5E
         wS2WH+Sk3phlKCJMr4bRm+dmCPQ8Oj2n20YijyEQBEwQ6Af8LkZe8NjoHxb2E0EvL7k2
         S3GjEXq2YHMMGC9QS1KYpA4oLboRpMR/C3JB98Pq6Jk1fNoAGb3/xBiVfydHG3MLhI5B
         ewlX8+8HP6TIJB4R/hraR53ezXzGFWf8ZuBPuINuy4ngCu3g5ABeXC0w0MXDalLKfn9R
         6tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790273360; x=1790878160;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFYBwgGLU7KRklqsfMrMxCRpg6dqYI7jhCcLu+nG99s=;
        b=XtqKEZzfHtS2cdi4JVE5Y/xZG5OmHsivxwwSPEAgiJ2v0VWHQKDcOIlE5d8mor7b3f
         WKxLw4sLeuvXd2qpCYcj+sZaMBk89t4WG7OjT/HFhxppokZOlRfeLIW/xLMaRw6AkJ3W
         MAYuYosOmlBMx7sFTapGntZ03Mwrit+gIOST/eMc+UMEVcWIdfFg9sg/MhIskr6WcZh6
         Od8QmdfWlYN8YZbz3/c1v8J/2OYQytIk5DE68BlFOtQNlJrF2AByvBDe518jKDYnQnud
         gh2ihj+fz9S9565yLFTNVlW7rW9bUhyGV+FAkuw8POCvQCs7Uy8FoEekQaYKtvJYRcpB
         BIFw==
X-Gm-Message-State: AFuF++kRaGplCM/aGGS5GYMxrYHgow4d2EVfnd2sNrgISM3wwQuK2bxb
	M+4gJOZsS0gAKILCIelXs4AMFKbuHnvXAUyu4Z1R26J9wDMzf/Ho1V5A
X-Gm-Gg: AYBFou3I6OlGRPmcQ/dZKMU52BVvO4njMxCh6usnkc/FEb+V7Gui6EfObAicndRT9AH
	NM0MbMP31APqwXcGdcL0g4NRKmlTTn+hmJExQwsisQsiRVCeGy9qh3qEpWUDe0PTmS5D899/vSq
	UftRXHAxP7k3yWm6QApP5LgC4fyKlujqFkTRnQP9cFulwoB5KZCoAb9XlfKB2jbuITn1s4ksaCi
	K2b3wCz94llxT6/h5HcanJ+SWoijsKXoAJ/GlxZYbQfS00uaDT9jnEGwIZGnggmY1KRMyEAT7fD
	Ip2buJopilJ1EhQV5dM3jXdmbRPuRtXhSLSkBwBOhXHFkEYeP9MiFcVywDDqGZU2UE7wWDh8nU6
	DNKJ+c/2kORNLbUsKVGzCmPhdD5SKKdS9L24Zaln6OKnDvmkwnQ/2D8Ugn1PoiPBMLFSk24XRiz
	DVgwfZ5MI+HTg8M8CJyKp/xVfM5AClfJVnhgUIitDdLT65aWfr6UHvMIlSR+zf5K/7f9WxUCC+T
	GDAHfOWkP0GQo55lJmOGkNI5uhkTfN24sLv6dKJP/BXCMfgfOopPplF91SGmkQJ3+h9lGqq1sr/
	Jzs=
X-Received: by 2002:a17:903:1a70:b0:2de:834b:b594 with SMTP id d9443c01a7336-2df7dd8dafcmr29228855ad.74.1790273359712;
        Thu, 24 Sep 2026 11:09:19 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78796c314sm133500a12.29.2026.09.24.11.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 11:09:18 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 18:09:18 +0000
Message-Id: <DLNQXUW5LFFJ.1HNYVGBZVAPMS@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs
 (callx)
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
In-Reply-To: <cd0ce2d0-8c56-4382-a384-24c8a52d6494@linux.dev>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com> <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org> <cd0ce2d0-8c56-4382-a384-24c8a52d6494@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 10:50 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> Looks like this broke GCC BPF selftests build:
>
>   progs/verifier_callx.c: In function 'apply_op':
>     progs/verifier_callx.c:977:1: error: indirect call in function, which are not supported by eBPF

Right. gcc doesn't support indirect calls and the C tests in
verifier_callx.c and verifier_callx_rodata.c have them.
progs/callx_rodata.c has the same issue.
Fix is on the way.
