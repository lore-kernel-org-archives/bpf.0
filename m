Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1747206F
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250145; cv=none; b=CM76iSNuwmh572PQuB/eb4kPJn3/DtSsfOonsrr3BYa6p0Zy+/OOEuiIgPmGtFtXHdaCUMg0gaf1DcpA9SC7vnxWBSahNr2ajhT0/fsKuFrjVVGMQt+SjD4mYYgADcxAlLSbxDoYZcGGRDYzrQ0QDpaSW/uPyoPuL81rESIbDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250145; c=relaxed/simple;
	bh=y+GTJp304L8CbMTWS3RD7lr8vUzv/GFB5IBYNOpIGyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVN6uPsTFtohei7rlVEJGWHITPT4UoCufpc407AWKDEBCZo79O4j/TOpNBmhp8nTd/KDR12lXMJcIVWQAuYyv+Ss//oNzosUp+Vhz2c+FSItqeEs/HB9zf9V0k4LZpy3FNv0Yi9XA0cF25JDFqGMlUFDZgL3dE0DOFxSVHRTLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F57PMMrY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3N0o3/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F57PMMrY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3N0o3/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788250142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+GTJp304L8CbMTWS3RD7lr8vUzv/GFB5IBYNOpIGyg=;
	b=F57PMMrYU/rgrggaJ/fZs3vnkVgZmp7waIXQ+vEeFJxFBgE3G0RU1Hp0Vcy7igYpiOwsGh
	nqDlD7KlG+tnkT/YjeCG/DReq+AjtXK7GGmhs4RVeN2ycyGOw5BLk4yzMumfX/3PIbZ9JA
	dDouGBMOTEFwELglaq12+TXG8jifuAY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-hShN9XnvPjqI9wxW5nIvsQ-1; Tue, 01 Sept 2026 04:09:01 -0400
X-MC-Unique: hShN9XnvPjqI9wxW5nIvsQ-1
X-Mimecast-MFC-AGG-ID: hShN9XnvPjqI9wxW5nIvsQ_1788250140
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6db77430so2331525f8f.0
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2026 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788250140; x=1788854940; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+GTJp304L8CbMTWS3RD7lr8vUzv/GFB5IBYNOpIGyg=;
        b=D3N0o3/QJlSrBE1XV6w0rfuRlQNoDAG5aTyYITGMBMLZRhz2A8ENCGmeHPXUaScRFg
         1EMfons+tJ1MJlD8AtlxEPsQw3yXpG6PqyuL7VMb00NtDforqapQgeeSWI2bwUwZMHr/
         7lMko/ShEAzzbBAtd/DhWJ3AuN3ncCmnyD59QrffrKWB6g5QgqPGaMMtVk8mX3wfej/N
         Vw8YXeW2ScKevZrDStOFcdM6OXehUYIQo0endXMdYzTbtnLomuizcdg4JdH7BHdgVV/p
         lYthOgUvBgOm29sFjRW2z7MU1NilRac+g6bBx6uHjxE4KXipX35kFmEPDitLzbU/TS2B
         yVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788250140; x=1788854940;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+GTJp304L8CbMTWS3RD7lr8vUzv/GFB5IBYNOpIGyg=;
        b=Hx/1qsEVrrUhOafCkPqeI7TPQamYd5/iU7zYwmspv90e+4BOuOqf/mi9OJfyMXeBLd
         HwQAIFBt5jWPdtFXVQQ7qrs8iOJl5zAAd3DXCXGCTQUkU+/OR0EqE72jj+Dt9DVUWCIc
         VjAAmEe7dwX3TU9voGX9CqZ283aa9NPLsIdKrWyqs26Xqv0FrHImXTt6EM1tD6PUoo7j
         d5lpsTgw6YW+s9GSaBm1FFgpgcx0uRN1e+ZTYOPbfauJ4tAD5QntyE5rx/b7o8Z+V/e1
         dt7jY0j2ZAXM9DV5r3IJ2v9PDsLx5EvklkoeNB8BiJlTXSxBinofgfQU0NnQ7st6zb/c
         l+yA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6cKpv++3M0CI/D0JTWRqO0reBQhKHgJFpyJTY2S8GewRLdz34rqHOhP0uP6j8d6eHyEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kiooN2CsdsggUJ6sJdtOgL/pzfZ1tZrNRea74yYPJCiU0QhEoI
	Zt/iQcK5IXzWo6d7b08QzO4deqEFSf1vYTe4ihF+HvQ6E/d7b8uHd6GQGVhMn68SLotocN7i+PE
	MVUjC1FDmofuKqnC4P0FeQPaXdeji8OV/bQ6WiZmgAEh6B6deTd6+8A==
X-Gm-Gg: AR+sD11BtHkeUcO3AZ+5PzioB7VOEb40+PLaroaj5Crgp1GwAAvdyge6NTUJv+IifEC
	nA40/cI5mgpBJ1/4SYfkxp58T2KjC3E4Tb3I3+F8cjd4SriBhAXX3E63VcKBHs4rJzQnomczQUA
	5q61ot2zngvq4qR5Y1b2VJBw3n/9esE99g/xBg6HnnvQ03/W1pl8d9GMa4Flc+5b3SU4rudI3dn
	r7NS8psm6gCcUjCHQiPAvITofQY5hVy/8XhZLe5hlmHpWVw6NHbgponNvHwd9wBN/O8mD71AiEX
	sdvp2opmXJBzrWoHAlwR+r27Mq7IhdWQHmhxK34R9enbByqwsQvTSDfIlNHjVdpugSB1s6mYvjD
	9z8aYDOdT6mIYV3qqsv8dxnHP
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cdc405494mr118156345e9.1.1788250139489;
        Tue, 01 Sep 2026 01:08:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8411:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49cdc405494mr118155135e9.1.1788250139078;
        Tue, 01 Sep 2026 01:08:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8b9a2efsm154174195e9.3.2026.09.01.01.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:08:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 94FDA97C4A4; Tue, 01 Sep 2026 10:03:23 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v2 2/4] bpf: selftests: Check for flag presence
 in bpf_program__flags()
In-Reply-To: <b256533a30204621a9d7963031e0033d87a88f0858ce6c6286a2fc054dd6ca11@mail.kernel.org>
References: <20260831132648.65843-2-toke@redhat.com>
 <b256533a30204621a9d7963031e0033d87a88f0858ce6c6286a2fc054dd6ca11@mail.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 01 Sep 2026 10:03:23 +0200
Message-ID: <87v78pv1o4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> bpf: selftests: Check for flag presence in bpf_program__flags()
>
> This isn't a bug, but would it be worth using the same 'selftests/bpf:'
> prefix here as in the later patch of this series, so the whole series
> reads consistently?
>
> The sibling patch in this series that also touches
> tools/testing/selftests/bpf uses 'selftests/bpf:' as its prefix, and
> mixing 'bpf: selftests:' and 'selftests/bpf:' for the same directory
> within one series makes it harder to scan in git log --oneline.

Meh. Won't respin for this, but I can fix this if I end up respinning
for other reasons.

-Toke

