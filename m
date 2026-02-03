Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DF257452
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139308; cv=none; b=BWvBZEj7dTHavwXOSsbWR+aIQIeBN/BWLLoVfAqRmcS0Zpr9oZM4gB52avTDJiFuPs9EPai+vTv9p93NCJj7MZl8AkFvECNJBHs6iw5zW9ZFlmaWWDMqTl3ozqFwBC3/wFUmo5ZdfC/pfkhhb+P5jh4cVY270LGikCxR9l0U1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139308; c=relaxed/simple;
	bh=gNYfxSzrlY1ehA1dw8n0k8n9KmY+fpO+otwUWszbNe8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From; b=YFRnMiJH44w9BzJJupoLb5Vm0XCkIOqi2621BY4aJtZfG95KMk4jJ4jxhJTq2OHr6yDJcn3na9az7b7xK/kaNf5frk2Vh/eArIXF2/V2VyhkxBXZBvY0yFBeU7JLK7hcbfbW+CCcMkoU0BBLVT/7AWWOxBIM4F25NNSaOGNDzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=l/fiREcN; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="l/fiREcN"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso721966d6.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770139305; x=1770744105; darn=vger.kernel.org;
        h=from:subject:to:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2aVPdKxkV6zbrAgvYDqj/iJ6OdBxk4wkjF3VbSKWhiY=;
        b=l/fiREcNgu4W7qNT1wfriZgFcMFJ/lZoMpOpz8kQPnel2kD8raXAIanrKw0az2J2nX
         oRCDepk/+hjAG+kUT0SANeTyOczc330x8A0K7cg2jpQ5w7RiQhsghWBU5ktpaPOypKlm
         aRNWahjvdW4tDBK55oNi5Tp4dZAkaXBUEU+rPFRTq57Ebkbm5n6gpafhqgEcp74xsbIt
         c6NlAY94ykaaBfv+3xdx3mVra9Bvei4WfS+kOm0wiVmF1eYTPyF/zw//MXaGdHE+7Q7K
         Ffbv66k6U2emcIbV/nWCBm33F2q4iLOrDh6Hyy80NfyOowaJGo6OegydlxwjLcYH17rx
         Mx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139305; x=1770744105;
        h=from:subject:to:message-id:date:content-transfer-encoding
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aVPdKxkV6zbrAgvYDqj/iJ6OdBxk4wkjF3VbSKWhiY=;
        b=XDBI8hVS5YMafFTPn1Mhs5Mb+7RBNX2ZNtfPJqKBWu/uZOAMwtGB8eUYPBFpnXv46H
         W0Y596DQ45LrBzVwtUtqqv4mhBZraqzvErwEsBhLgaOTldCUd6m7hrs5rUhcGj1xDkX4
         +VTsGl9OvmnxbF9FkZZW9s2dYuH2a5O+Yct0PG/Yjhz+OYOEYhFGgMiQ6fnFSWiX1M4/
         K1UOk+8uhSqWoVppQoDX6q1esQDjZthjAjJEYtotd2yuV6oRSnkcsyJdMTtwPJw7E5ik
         Ny7KsujHJkOMQLp4pDK4a8/tFwxgimABb+B4eBmrCwmpBSPpP5Ukrrlbpcg1FxPvhEZy
         ys9A==
X-Forwarded-Encrypted: i=1; AJvYcCXA/U0gK2MUIRhCbsXmMeGCFwl+uGyAfAcJvT1dHRgDzlY99Ek+f4Slbt6kasts/nQzhTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJ2GT0lRy+J526Up54AtlymrR9mb00Fop7/uKqGKU1ZRWOBlJ
	FojtoCTBf9+6Ty8rQf2YPKSt5xbW5nFDQIJcGa25wGZnQFJ7npFxx/lmn04FSy22p8Xl3jQhFDA
	QIJCy
X-Gm-Gg: AZuq6aJ9VejKnMi0ibWt8e1l8QIBvoggqJXBfnzHGdeW4YVAo2gIQx1QCwjEeOn6gwv
	KISR+e0uKjv/TK17DU5RU97VlxfBq5n86uNdFQLKytAbhCpNYfqtx/VMjFjsadQOQEw2FPE/zQD
	GyR1zrOLLB7O+SwzOQ7pDMlxyW5lhL8BnSWf42jCt1fwGn5+DzzxVIHJKzse2qBSJNeZFljhSjo
	eids4iw7wCm+fkCBBG4dh87smW0aUvrKklVZ997Kq2XMwt9LzL8ERqFtGq6E0MEVyK+xRTxen+K
	4mDebOetvD/vNvCI00B/8VydI2oiNeQXPzrYqPTRLXAAKv8068QTIJHI4G8YP2H3WO3/GrNPhec
	cdPAPinOemPuMANw+RBWJBTedxHy3k9hk+6JPJSzrO6DCobvtO4ZkWjjsdieCTWZq3SDppVnoUL
	WKQz7V47X/cHo=
X-Received: by 2002:a05:6214:492:b0:894:73dc:a7f6 with SMTP id 6a1803df08f44-895182fd890mr49390116d6.2.1770139304507;
        Tue, 03 Feb 2026 09:21:44 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521c1b4d3sm1760096d6.21.2026.02.03.09.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 09:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 12:21:43 -0500
Message-Id: <DG5I0HN5PK5E.226I37YS7YY2P@etsalapatis.com>
To: <lsf-pc@lists.linux-foundation.org>, <bpf@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] BPF libarena Development and 
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1

Hello everyone,

    I'd like to propose a session on the BPF libarena library under
development[1]. The details on how this library should be developed,=20
managed, and provided to users are still open. The session would let=20
us discuss those topics, along with sharing an overview of libarena=20
itself.

libarena is a collection of arena-based code that will live in=20
tools/testing/selftests/bpf/libarena and will provide a runtime=20
for arena-based programs. The library currently includes memory=20
allocators and an ASAN runtime for BPF arena memory, and will
be expanded with arena-based implementations of data structures
for development like B-trees, RB-trees, and heaps. The end result
will look similar to the BPF arena library used by sched_ext[2].
Users will statically link the arena library into their code at=20
compile time.

Possible issues for discussion:
	- What kind of code/functionality are we interested in hosting
	  in the library?=20
	- How should the library be provided to users? (e.g. new repo
	  in the libbpf org)
	- BPF core features/adjustments for libarena development
	- ASAN status, feedback and possible followups
	- General usability feedback

[1] https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com
[2] https://github.com/sched-ext/scx/tree/main/lib
