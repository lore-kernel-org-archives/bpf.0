Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7EB363C53
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216021; cv=none; b=kKfbmWWeg/HypP07xlmf2+/OYNoNZT3OgwWHCSvx2bX3SLJF86X3ZZzEOan84rK6gBmA8gunkfUwA47gpVj1IF4t100V6JVL1Eha9mV/G2+ysYXSbuRABWcDyOhLNkGgSQYtMx25lM57h2YMh7v3+tO+6TW009nRxpdZiIA2tMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216021; c=relaxed/simple;
	bh=TvRx30cFFBxM1lZHmrHXN5AevRD8+qL2F7Yw8EV56EU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=fAra477o3egAzV3QywcSIbCuYrc6COkJveyKPdKdcdxNQPyD6GQypb51am6gB8wSdllFg2WJVoIOp34YV7hipski3vO9wm/mkfPibuX2w6RzueqrybKPleZefuFZ7CvpIcNJoimmD9WGI7kHtJsJRUqcNPwkV1zk/+MCI/uq2hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIPaUMjf; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIPaUMjf"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso1031268a91.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790216019; x=1790820819; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xiHWdzGHER22+6KLJwESfq1jKFhidXE+LiL3DuCxm1A=;
        b=WIPaUMjftL24hFxXL7pOsweB6CCA9H5MVRoBsLSk+ZClAeHJr/mUqk71zGPdUjvr6+
         ejeW+D9vLt/LHkoBi/YyqHwW7++9G9+GlGAAthbs0ce/HEFC5Uy00ip0/WeepbZPD1Y7
         vQaH55oxzvDC6r882OYByoRQFs08T75J9ItK8NwyNMVWsjw+JeyvNQYXBJSRk2acPkh4
         CtLjNfzbsGmzrT4iXgMMSW/3whRt4O5Yanut+kv7zgs+jPZ0gl/8xBaeHiCupw8hlbXC
         WUB1nMRlgxGSPeOo8Jf8BBUdPGN4SCL6XdERmMVZml/LLF8+2fznC0l5u/veQBzImuYk
         zEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790216019; x=1790820819;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiHWdzGHER22+6KLJwESfq1jKFhidXE+LiL3DuCxm1A=;
        b=zsUd3FWZ2JnEVDy7fKIVq3HJEnNV4mCvPGKdDEm2p3S+RXyua5CymYHihciR0cd6NR
         aIecq/A2HGhA89UP8Pc8HnkOS3LwLvlu/56QSINBCnGp95R2QCzdC1rrl9XBLSWzmcxH
         DyYtyvfEbfCiu0uY741FFgCXUtN2h59M4qwnR0x3/SSTiqirdq45Mxq94ED+gUEuSwjw
         HfWK5B5fGrVYWMsl3iOo0NpNFgJnJQuKSLEq6n/L0BZQKvD8KiR3LPQ6m+4IKh0WE8Vs
         CIgSrF98SaVCRcr6IghstmiT7DBb5LiYSltljpjQDgCYLlVOMGEeC4ssoRAKWXZzpZq2
         /6GA==
X-Forwarded-Encrypted: i=1; AKwUvByIs18skBsGHR1S2uK+d2RIx1URm7k0s3LwdOAp1nBYhUkJ4QxPr0NQB5XFzEelhHyZcdc=@vger.kernel.org
X-Gm-Message-State: AFuF++lbPb4BPtthKm65QMayW6TC6l3iF9NKgIaE95/z6UdPt5gB+PVV
	vR0L4rjwBlHwqhqytLpyiEASbGDwM33n6s6NTPNKMFHyFvkvlcTZ+P3G
X-Gm-Gg: AYBFou38qO3vzP/sedC0z8pEaD00D3Hgmmg3RhYFVM8SNK+pL8PZIfPnFmuTHhzCou2
	an5XtWwTP8/FQ2F3WEfXCDS+kuOnElMJJSjp7wVQap7zSuXBZbzecwECdIVni2hSAFkp6xr6i/E
	NS3N5H1O9q540HgTKpbDXVeQB5I6AxK++c2tn1bUMf6NvLLDiqjyzVLIjSjWA5rXcbwsTqNYxUw
	d7q21wr8kJrSahhRO0lolt9/uvtQmeyuhCIawW4MJQOj2qx7ua5PoJZbkgfzbJj8tx9e2d1J0ve
	wNl77LPl18nkRVSKXbLNcOKbx9/zdKl3ENIWk4z5XmvEJQfpi7RzfVxZwVUb9jaNr3AI2550B2i
	tV8NDT0lxQvcnnq5YX356pnx7HMarij2kcmnT0WfH+xWRvZDAjT8u4b7H6zz1j3xv/5KA0xcbJ/
	PWF6MtryeTKYz64seLeOjUKyohfVlCJ+C8ei+Ge33M7PmolORS4XNkKQf62XzoG9+sklYhAgc07
	vncoeQgNERe1l6L7JKp673DkeUIvhNZQgCg6I4qIxB0r8xMkwAje8WnHVJANSzVLDf+iIcY8Dcl
	4/BkuJOuAkLJSOI=
X-Received: by 2002:a17:90b:4d85:b0:39d:f254:4173 with SMTP id 98e67ed59e1d1-3a098d9612fmr954796a91.21.1790216019096;
        Wed, 23 Sep 2026 19:13:39 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b11b5sm1824625a91.3.2026.09.23.19.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:13:38 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 02:13:38 +0000
Message-Id: <DLN6M5A8DSM3.26QGE9RE1J375@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <a.s.protopopov@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 15/17] selftests/bpf: Add tests for callx
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <93380e845ef2c8c3804dc961e2dbc9b21acb52cbf22de618ccef1f568ca209d2@mail.kernel.org>
References: <20260922011323.1298619-16-alexei.starovoitov@gmail.com> <93380e845ef2c8c3804dc961e2dbc9b21acb52cbf22de618ccef1f568ca209d2@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 12:33 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +/* return value of the callee is tracked */
>> +SEC("socket")
>> +__success __log_level(2)
>> +__msg("R0=6")
>> +__naked void callx_retval_is_tracked(void)
>
> The level 2 log first prints the callee's frame state. Since add1 is
> appended at insn 5, the log contains a line from inside the callee:
>
>   6: (07) r0 += 1   ; frame1: R0=6
>
> This line comes from print_insn_state() and matches the __msg check, even
> though it's in the callee's frame, not the caller's.

Right. The first R0=6 in the log is from the callee.
Will add __msg("to caller at 4:") in front of it in v2.
