Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAF38756B
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549512; cv=pass; b=r454I+rsBSZmTLqq8DHQ+y6Mfv5KmRENgulWtvGUwfTDbggUbZaYEjwgrgBESt/cNNhSLOq6BDGv2anCWjBoaku3pHplzh9YHYqDocRILKX7EGfYpQCH1B8Q1hkmnvWsCJBUuWT3OjT20CYa9js1CZd/BvqmQF2cORAYHfeJ+NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549512; c=relaxed/simple;
	bh=VcTAEuXIgazbam30v7h0INbBTK6ykVLaAc+NDs8de+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLC6ands9PU+Ztd9/cqnXvfZ2mJ+MHUZ6oJM4M0ptwPAIkYhGjdKqxMYmy5qqGkYbbdwbnasPIx58LaMy8PzQyiq4UbDlboFcedlVU8W45Tt4p1FJcQwotMaDG5DEp3JQ7J3NK2jEZNG3o3QiOjaClUxoNMSFM7Ee6ETU/qtvqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BksYknTA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibZmvTrq; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BksYknTA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibZmvTrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772549510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcTAEuXIgazbam30v7h0INbBTK6ykVLaAc+NDs8de+k=;
	b=BksYknTA8iRoj8ISFtprmrM+KebEluCn04vOOZ3Q4FwhP4QRiQmc6qiDoYvJQAqRQ6Hsih
	D9dPhpcJF907kDREO5ayCdhBQM0kz1ebUgB3EDnXbnF87UbWoa2ThvbRj8AFumeqcoW+2u
	J+YPBdvhE8wziIGxO1xp2X5TpkLibfc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-YTIpUc_rOzOkhiuu-iiH3g-1; Tue, 03 Mar 2026 09:51:49 -0500
X-MC-Unique: YTIpUc_rOzOkhiuu-iiH3g-1
X-Mimecast-MFC-AGG-ID: YTIpUc_rOzOkhiuu-iiH3g_1772549508
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b937607a902so554391866b.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 06:51:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772549508; cv=none;
        d=google.com; s=arc-20240605;
        b=O+TXA22h6UnMvSauD1LtrdGxjBTy/VJFGzyuSZxZurAdqi5oqoRtEO65d22ECHIg23
         reyiMpofVXq8iG+jhI5IDWMko+enVv52kv+E5CBuedJA4i+GbyddFegMStOKMfW6kH1s
         ix53Qu7zD+ArmKT0VJhR5NHlEBOsgnl60QBcpry0jIz0xz6W7YukpFZASiqmVj8spPvb
         WPxeGVspI0GTD9lRBjXeLXWFG4ses2Rl76D/Nv5GNeSir9/mj8FtuyvxxvqLQJBrC3Py
         8o/Xo8vvbGdPMoILs09KmACVJ4Ld5NVviVRg1GByrUGzKqRD+Toy8Y6Ng8zZCndEU3GG
         Uwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VcTAEuXIgazbam30v7h0INbBTK6ykVLaAc+NDs8de+k=;
        fh=cv73xazEMEEcRqn26A0BLaZi6iWSlSI+3WmV50zTYug=;
        b=XGkZmYOl1dNXy96pMHuuaflcEzJn2bZ2Uajyd8FqbqedaNnXplStCDYX3bLEP1CLAO
         WHP6irLBGO2TbR5PbkPreBkMsgvviQmm+xinB9U+aM/sTpNavqV0+BYwILslzCwJA9Sj
         vq7bCphE95PyTZ5oP7g6RPoUE6ovtxUCiVdzVsvLA+P7izkEk7c62M84uSDqnf1moSYk
         tKuMoiDf+u971gOvVHCBt18V8ZjRk+7q+liGSoBmzkz/yPETYc4vEecZWdjrmH0YX1aL
         YQQwN+CegWcWVEdmCMJ9dxkF1F6eQJqbIkGaXcTJkniA7Qxk35RltEVG/W2hCDHjzo+g
         Ri2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772549508; x=1773154308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcTAEuXIgazbam30v7h0INbBTK6ykVLaAc+NDs8de+k=;
        b=ibZmvTrqd/RfNJHreuqfM72CbnJ0KJBHtjUfZjieiSs8+vGQ2M1dJnyqQEHC1YA3MM
         lGveSYFeczaCI+vuyHu4ZdoOUnTpy3mJdqZ6igm0fpos0muU4wzbcd69xK2cOrDV0YVE
         Ds9KguaHi7AvkqwxGBmAOSsvYtvb3LmrqFZXmd2+8wGfMWKQ23h80zq3EH8yh0MJdhEm
         E6gu0yqMevIf9G0NM6mgwpLat4Yn01Ck3QypI+N3thUUHA8f9XRrwloq5O9iXdr1vz+Z
         uaqve7LwaFP3jcFiqZPXX2Nk/wYUXNGc1MwP5c0LcfMOylkmh7aRxIq4q36YjY3zqDKD
         NRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549508; x=1773154308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VcTAEuXIgazbam30v7h0INbBTK6ykVLaAc+NDs8de+k=;
        b=s5mEK+ARzJWT/zUsCFrTgo58kBSUUq5+tMKnGCGHpzH8m8Mupk+xpNjCvpRaBV4IUE
         KFW2VLBYecPoOFcBOS23QGrSP3dxBJNN5J8Oly5FhJL60RJItTqgNUXOSeZ97r3eSGKc
         gKyu1uJnaZesG+GR1aLbM6H82AlroWPqQ1fRRpy4231lZttx72fXBm8ACLBsDKnhZmsJ
         oVuQxwIyRdAJFck6FlbHrcT7u6kSfzh6kBxi0gzWH9DAGjCxP4AmX+guf/Kuj0hiNLfQ
         WBL4LxTt63hkw4tJf21TCZCqHbJg2GEIbh8flVf+Y6eC6I3mgYsJlyul93+y+pRmH3r/
         4ixQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnVXO/54O/+ifTa1JlcHPCi6D1lQ3pwT95WbT9MyEOTsdCdfF8lEw8sv6lY7XQ9OlNgD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEYPuDY0jn55C6laXJdgxj/S2Jz55tgz4ipdJd1nRcn9hGYkP
	Hk9B+gdYlhrTZZTVqvobrRTY5L3RQMmPLPZPzEbGOtqN+Od8QmYVwXLQLdyU6onOX/NoI5DQHFq
	Em1aa6PVN9oForUOuHSiB0oirwGc0+3INNokhrOkYKHeP1k3eDQ3lZRUJ3G/6z4DnPQayQiQzNj
	1El/BZvnpKeKryYjjpftlrVstDhyFg
X-Gm-Gg: ATEYQzzYvgpw1acVPsrBx2HkhtrM5Ro1KSSWTIqy9aKkTfP9gKYU98VwM1+/iVMHECK
	1iKlvjgWAPQzDiYtu/3yqP2lhJkrYuRbSwJXn0JUtxnuqQcoKBF0J3XsrHXCK3ElIIhgrgeaY01
	AiIYlbQKSLtqdmgMc21NXHWDbyRJ7EYdVeCu/Q1nUxMbkgioS8hGgfxpdOZpj7dfA2KDlG27LnK
	fBFOg==
X-Received: by 2002:a17:906:f5a6:b0:b93:5fa8:d7f9 with SMTP id a640c23a62f3a-b937659f053mr1099835666b.56.1772549507761;
        Tue, 03 Mar 2026 06:51:47 -0800 (PST)
X-Received: by 2002:a17:906:f5a6:b0:b93:5fa8:d7f9 with SMTP id
 a640c23a62f3a-b937659f053mr1099833466b.56.1772549507290; Tue, 03 Mar 2026
 06:51:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-16-wander@redhat.com>
In-Reply-To: <20260115163650.118910-16-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 3 Mar 2026 15:51:34 +0100
X-Gm-Features: AaiRm511X9QNsDzw92mihpQidwgDFGXSj9GKUHHxoZ4yY1UDj2VYOgC1182-m6U
Message-ID: <CAP4=nvTy6AE2i6ziW+jtWqrDR3CMVPDMhNE5bp-cVMs9_D=k+w@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] rtla/trace: Fix write loop in trace_event_save_hist()
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:29 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The write loop in trace_event_save_hist() does not correctly handle
> errors from the write() system call. If write() returns -1, this value
> is added to the loop index, leading to an incorrect memory access on
> the next iteration and potentially an infinite loop. The loop also
> fails to handle EINTR.
>
> Fix the write loop by introducing proper error handling. The return
> value of write() is now stored in a ssize_t variable and checked for
> errors. The loop retries the call if interrupted by a signal and breaks
> on any other error after logging it with strerror().
>
> Additionally, change the index variable type from int to size_t to
> match the type used for buffer sizes and by strlen(), improving type
> safety.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Looks good. Only thing is that it should have a Fixes tag so that it
can be detected by automation (e.g. stable backports - as this is
relatively old code), like this:

Fixes: 761916fd02c2 ("rtla/trace: Save event histogram output to a file")

(on one line, Gmail may truncate that)

Tomas

