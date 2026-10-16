Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FA3A718D
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190597; cv=none; b=UI7ybzFAdEUh1BHbsn+BowtrPUYp8XLDeSOoAw94PUev3F96kFHapQbEK56YDoiLgjn0cM9MPYZAr7g4iwyF7avYlHS/3LJd5MJvO8A6sZcpSA+zYNiuc5Wn6D/VQNqIpnjLaCWHmXh1dRbODIf3VR4uSGUxxtPMgBdxH7p6MTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190597; c=relaxed/simple;
	bh=aJWthHwm+KCtzk67wq+DpNqKxiLyq8Zw35QkTXjbWpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxFl+bien3ZJqjVhA76b0DDSURRmtHVPXtXxbU9Iutf8qQXiRc+CdEd3lMCGFt+dzUbh+lYVht6x7fM72K4JryuEiME61zVrS/MkgnBPmrGucqcTOdo0YgFAhkGt262hnziYAzPXZ+KKvV656yFaXFypiwwJ0YVQ1JTFz7aDK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6s+PvIW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6s+PvIW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e49fbf92aaso1946335ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792190596; x=1792795396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJWthHwm+KCtzk67wq+DpNqKxiLyq8Zw35QkTXjbWpA=;
        b=b6s+PvIWkU6F1v8ek9BVKryMxo3Pp8ZNEL+f7Gotus0cR9kh5XIeljDijQUJnQNxPg
         evPpvHDreSVLecsfE4p0TZY1IFv17ijIZXL2huON7SwuWL6Cx/WVx9kBuLsBoXu+EUnF
         drVcgGJC0A5WPnq9SVr7G9ddO3LPEUFEU1mjp3kD9bhGDfBGSD4oKuya5aEMCmzk65ZA
         tLR9/GJ91hrfRxNWsYCRnnujPOE/FnXAwFQff5FKJ+w1RUzHYtuvbBdyBoSluNNtgw/P
         vlQATeOSWZDjxdGQKTlVJI+b6ErMEyIE0Mj9a1z9BSkhRyzQ0AXxBOVuarzTW4Hl9esm
         c/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792190596; x=1792795396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJWthHwm+KCtzk67wq+DpNqKxiLyq8Zw35QkTXjbWpA=;
        b=AJpp6b4Rb7qglBXrVVywinRcZqUc5LUtxu1TEB9WhCJ4T3M9lEJRaDNATlNmgbRvNp
         ICJhzKqNFD2XvcfSP7J2mueSiIKZZ/hIt3QpW9+s92HnHUUA2a/P0Cb12m4oOF5ua8Nz
         UGwxeyp0TLWRiGmTvd9Z5d8leMiGnd7lGXqLdmJt6qMNMhyTOotjcMtnrPY8OETCmEoM
         T+LH4EfLfp7Wcz5mlCUGRNdLBAEnfd6ZbPp8ss1pjnUMm51JCAtmriBDg6m/VmlXio4N
         XRuIzwGabKnFfuVaS2RzOubZeScae169RizjAXmWC86hTOIHpyoUEH9GB54Q3mQpQ0vB
         huMA==
X-Gm-Message-State: AFq9FYIMd7legYHAX+/hjCXnroX2cpiR5g4pAD0oY+AHwPtDOKBitpmx
	08j52ZaHyYsdEswqJwvHGL8sg/EMBankAIRE495Jrt6YswneKtW7BEUFh7qJNQ==
X-Gm-Gg: AYBFou2emvDW7/tY5GnZf2e6g6tUt5OUlJaghyTCu8Cs6xgk6RKOlCc2vWWOqin4FlF
	Ycjx8tpSFobAZRrcnZwN1ppNYQwbygji2UOz9uu+2KeF0fpBKgA6KWIR6gHqjLyM1BHyUR7RilM
	UqPh71Orqdx8NbOdeZTxeU9Q5HXdINr7k1W80N1K/OHdyQTcR/HED188YmhbNBIzDyBs60Y20Nw
	QQC312QftBQWXcqAnanhtDRYQsWoftJeigGvnvT3R74lcamSskMEpMwatka5EmDliU7AVBOPo+a
	cvpmH8HG8gMcp9/C3AYRflEOQBFqbO9lonwekLrxshcOINK1uLzGhXhJ+Hurlyzn1T6i77GUf6/
	oxz2HB2Umx1VPcFtOJ6/VBaN3ULrmhXR8uHbirZXt76jnKDHsGMA+teLvxXKBbY8djdmmqz3rIr
	5/83sBx5S4csWp9hFzGLA7OFiIvkbfPAObFdUjRA6Yy1GuLNDeqBLV5PGn18ZMqeSWMBPexpN0A
	37zs/W/KOK19RuLauN38fx66IxkRTEAFxzgsAvqdaynnzrmJOWKw8oEyeMS6gV0gszo9dRZhGst
	KtIdQkbaxRCNj+X0HESrpR/XT2RPGegPWU6yJCunTzdLlvgbFrmrNA==
X-Received: by 2002:a17:90b:2c90:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3acef0fe32cmr927014a91.45.1792190595794;
        Fri, 16 Oct 2026 15:43:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3cc73c7sm2596425a91.4.2026.10.16.15.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:43:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [ANN] Five questions every patch has to answer
Date: Fri, 16 Oct 2026 22:43:10 +0000
Message-ID: <20261016224310.3135990-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

Two AI bots, sashiko and bpf-ci, review every patch sent to this list.
In six months they reported 522 of 636 known real bugs in the posted
patches. Median time to review: 19 and 53 min. First human reply: 15
hours.

Reviewers: leave bugs in the code, bugs in the algorithm, nits, style
and commit log wording to the bots. It's wasteful for humans to spend
time on the same thing. A series can be free of bugs and still be the
wrong thing to merge. The bots don't look at that.

Submitters: the five questions below are what your series is judged on.
Answer them in the cover letter before a reviewer has to ask.

What reviewers should ask
-------------------------
1. What is the problem? What cannot be done today, what is slow, what
breaks? The commit log often describes the mechanism and leaves the need
to be guessed. If you cannot tell what the problem is, that is the
review. Ask.

2. Is it worth solving? Who needs it? Will anyone hit it in real life?
Is it measured or hypothetical? What happens if nothing is merged? Is
there a way to get there today? Every line that lands is maintained by
us for years and not by the author. "No" is a normal outcome of a
review. Working code, the effort spent, "it's v7 already", acks from
other people don't carry a series when the premise doesn't hold.

3. Is there a simpler way? How would you solve it, given only the
problem and the tree as it is? The least code and the fewest new
concepts. If your way is simpler sketch a prototype in the reply. Pseudo
code is fine. It's better to discuss code than a description of it.

4. Will the api and the layers last? uapi is forever. Is it the right
layer? Is it a second way to do what can be done already? Generic
solution or a hack for one use case?

5. Is it good taste? Many solutions work. Pick the right one. The bot
asks: is the code correct? The reviewer asks: do we want this code?
Nit: name of a local variable, empty line, comment wording, line wrap.
Not a nit: code is too complex, wrong helper, too much indent because
the logic is convoluted. That's taste and it's worth saying.

If you don't like the answers say so first. Don't bury it under comments
on the hunks. There is no point in polishing code that should not land.

Submitters must care about the why and the design, and answer for them.
The cover letter has to say what the problem is, who has it and what
else was considered. When a reviewer asks why, fixing ten more bot
findings is not an answer. Review your AI patches before sending. Send a
reproducer. Review other patches.
