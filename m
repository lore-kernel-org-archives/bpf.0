Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154092;
	b=taDaQMSAql0GG/acsU+Q1ss4dog0qQsrQyU6G3HXPaRuuDhvpNxZYXkQTso2jZNorj76
	 +T7H51NQX5MwNmcrrt4/BqQv67DuUkOzz/aH+v4JJrFKnwkhFboUJy1tfgiTueLlgv8nW
	 tybuT4G7tWA6Qpg3vwtG9Y7GdY4LtycZGnNQp9HzatCQ62ObBI7FRDIXgi3j2OXJW9LAu
	 APd81oNWOjQfGP5j7/SWGmbRmsnLJBD/O0jEaSTamVPOGEQbvUD5qjhKYKLlM/UGcz9p0
	 U1ql/yu89LeEhqcOYRRnvm/SwfdNIRSFl1l8MLAuRTO6L2otmqWgIjbl+EGET4x9Lcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gF2UiTKBERb0gFccvMdAM8b4z2m27E7dn9beS0qNAqg=;
	b=dU/aEl19lpfbHeEGHElpyrCic8v+A0Kj5gv7RBsJgOukOPL5ijBtDoFqs0k1PgVUs1xf
	 vJrEf63FPtjWz25Brk4t12aUUM5HzmaYFzUa29dZAAc645C4j3YNSxuJvv/LbvqUs25yH
	 /MbMArqR1eXEWh7gdpJbAKWQylp/YmmVzMTAp6R1T8Gfl77MK/kj5NUo0MZ17K+QLPiLk
	 yNFpvyGlxff0pYKDzBnuatSylXM+VoDqjP3zN7YT7LLgY8ZKDln4akM4rvYKwBruJFpx/
	 ylhMS80lXFexstMCmGqcw1TYNxQBQrxYycZt7NeY0hqp3J5w59G+RqZ6Y05fdCYFVHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bigxoCBq;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69258606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 16:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69258606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bigxoCBq
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so42184b3a.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794154092; x=1794758892; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gF2UiTKBERb0gFccvMdAM8b4z2m27E7dn9beS0qNAqg=;
        b=bigxoCBqluRe7zlT3MR7RJIsnECUJI3FdZv3rCv76QjJCngByd9Q+ElvIgpZ77vAf+
         ZpHpLWeoU6Bi80lad7Gfc7qVOxdUwg6zdZ8b0lIlzG9wOs5agPLoc5q+N3243grdeDKg
         Gq0jXx/ypfNOFLcg3bF9cTs3bBAe3sNB0AGOiw2QmxNI8tIxnGEwTEfMNFOzSnmklxIP
         fczIgHcW1K0nZYy1RIRfilpkNKhu//kx8MglKKJ4t4iWn8HX7mb1OC7vChuo/xqOLPKM
         OscaaeBEH/6Jjqm28tQOLDDQwigisvFG7smcn5Qp1945lE5DkJApJJCJeasCK02SPko4
         JPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154092; x=1794758892;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gF2UiTKBERb0gFccvMdAM8b4z2m27E7dn9beS0qNAqg=;
        b=zSEd2npMbmkYPPQwmLDYYcieqycdtaAS0J68dYqXCWLyXk0G7n2yQcIV2rRbDko0u8
         hPcPqTwVXI7BQzQCGjP9DYvo5YiKx6XhpWPaQR10MLsTSIDy1i0icdEEupJ/Ldn+kuHY
         y8WOv8S6XBKlxoHvS0obURYfx177040lkXs38xYQ3b06kvlp5B8Cp70cd6GdO8yGTXkQ
         bI8yoWy+7B8L1vM4WBIX6fil/g8ybZg1fee8TYt7+HB+rqiOdonnbwjENfobKxbA8fm6
         ksRu2DowRf+piOacjZdQZiGjWpP16Ca4WY7fxsrCdyPdchf2C98COPPgv1d0QQuUvCvh
         aE4g==
X-Forwarded-Encrypted: i=1; AL+hErGGu1gPsmkP6J0NHa2GRo/3Omt4Dd/EJhnrXMEHpkommVuYFWHFDdOj29UN/ZGnzyGS84g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2mlg7vThIdo+dBUPxKn/mhdfYtAwqxRBA/HfBNOPESiojYmMq
	AYDtxnHjTZYeJnhp+ki9L+Yyr9Urfvv92+hkUAxqNvx0FeoKh/srs5/HWCXy2w==
X-Gm-Gg: AYBFou27lEJdKeSgSy7aN0k+HrWMCLMtw11sYcWma2fnkcqHwvLkwOhtzvXzQCWix97
	kYCBiVVYNqAVuThu2NmrhL4w0pDGgIBMcBrIuAgIoDj/27Lw12co9djHmuszn+icsL33ojcNjmV
	+quzkihlVtKHhJWE72lSWoc7LOb00+9aDjCxB1KLa53gTciJpJEeiP3ZoamItt0H9Pd9hY25Upx
	NTT2+W8QchQNLlKXMlkshhJqSfuTqcKoMjucAs5TQ7MKyZYzVt7IC797wgtcp719W9ihSz6tJW5
	4Z0CB5suTil97PtJ39swwzCwpET8oJN88S2eJn7h7xndG2l28aP4pPJxTVm1dGMpvvd2AlUpsgi
	BYE17+C1Zuo8NdqqbjQUrWU/Y5p8VcYshzGFdFzN+i21h7nSouMGKcJ5cOgem6exC43TBz4iGNL
	6HkMwGdgDMYBhwilq0GIgqakILriqhdLKcRv/Q+WbvGgaVtR5OHhS1hOJfmSDkusCV32KO3xIO2
	BWxhBI5XLnnB1cGcUO5A10HZeiQNGO4riIrr5CcnWPh/Mub9SC9pfGEvqN1FdzJuxjx+ird0jAr
	NABRU3Y4b07xn4/RpUqDgKAKxSvTHuBTvBz1tJTfFf4AMA0Aefdq7dknV501GrMLClq7A0LoKTF
	5yLHvSQRLwBYlD7WzUHpCQyRC6u/nxaRuqiin
X-Received: by 2002:a05:6a00:1f04:b0:8b7:6ffa:f201 with SMTP id d2e1a72fcca58-8b76ffaf409mr630203b3a.29.1794154091558;
        Sun, 08 Nov 2026 08:08:11 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b64a1e6232sm610885b3a.52.2026.11.08.08.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 08:08:10 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 08 Nov 2026 16:08:10 +0000
Message-Id: <DMPYJMM21F1F.1EB1E016WALBH@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Take the end of the verifier log out
 and append it later
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-203595@kernel.org>
References: <20261108053937.4134138-1-alexei.starovoitov@gmail.com> <20261108053937.4134138-2-alexei.starovoitov@gmail.com> <sashiko-outbox-203595@kernel.org>
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

On Sat, Nov 07, 2026 at 10:03 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +	log->end_pos += stash->lost_start;
>> +	for (i = 0; i < stash->len; i += n) {
>> +		n = min(stash->len - i, sizeof(log->kbuf) - 1);
>> +		bpf_log(log, "%.*s", (int)n, stash->buf + i);
>
> [Severity: Medium]
> Can advancing log->end_pos by stash->lost_start without updating
> log->start_pos leave an unwritten gap inside the rolling log window?
[...]
> This relies on the replay loop emitting log->len_total - 1 bytes so
> bpf_verifier_vlog() pushes log->start_pos up to E2.  If the loop emits
> fewer bytes (for example, because another thread wrote a zero byte into the
> user buffer, or bpf_vlog_reset() earlier shrank log->end_pos -
> log->start_pos below log->len_total - 1), log->start_pos stays below E2 and

No. Not a bug.
do_check() moves the log back to log_pos in front of each block, so
start_pos <= log_pos there.
lost_start != 0 means that the block rolled over log_pos. The buffer is
full then: stash->len == len_total - 1.
At level 1 the only bpf_vlog_reset() inside a block is the one in
print_insn_state(). It takes one '\n' out, and verbose() in the next line
fills the buffer again.
So the replay moves start_pos to E2.

A thread that writes zeros into the buffer damages its own log.
It's already explained in the commit log.

> In addition, because the replay loop formats stash->buf in chunks of
> sizeof(log->kbuf) - 1 bytes via "%.*s", a zero byte in one chunk only
> truncates that chunk in vscnprintf() instead of cutting the rest of

Not an issue. Only another thread of the caller puts a zero byte there.
Less text comes back then.
