Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D23BED40
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063997; cv=none; b=V7SGiaY+xHgVr5byju2lf9pMKqXlht2jlUGyDXkx/jWOWwSaKtKnLD+wQtXYngYINgbrnXtgT7ERfb5UGDlqFUUX+IHXSgvQfpZZ40vLnj9hpIkYKplDZxZzWSZfBrR4y5f1z3BpsKfRh0ytA4elCgrhj2JV8EUlF6KYN1W4Ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063997; c=relaxed/simple;
	bh=iwjHllC5+JdOTH0B0ZpAx9JhaEblp3aG6UZS+7naJMY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kBriG10UuVaGSvTN09CbBJMNOXUTyCT2z192WAVTsMA45Lnu2T00dnfpoUnbUfaUfWhGX/v00biFJxrr1o6drsYgj4nWnHiIK7SX2xsx5KaGPQV0gWTUX43fJZVSez0pNKx12sr4U7SHiFBCM7w/kdEh4NO5iXAMwtyajuLjCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtrT7w8E; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtrT7w8E"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so4506215e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773063993; x=1773668793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BNZrYmR0hxM/DoGoq88/XwdM4xNmGaXW6cnlXqxFVCo=;
        b=NtrT7w8EF/M8K/pbuqUNePhgovO+4ZmgbKILPJ+dOwBMbRacbxrC8QXnHZMzrdV0JA
         QA03YlbSvN6Z2TpjRg2gflNyNziF1rW2WB1ZUkEu3J85UkkE1/kukXDBa6nfZuL/xAxg
         NGFgqLeTaZlo0Shl2pU272/I9oLIxewwyG6wTq6/gl3sx8IpgFs+fheUO1YLJgiHOliw
         ho06xIARkwVBC/uUghiHFwdIjzJJ6oKOr09PZmI3G6WPR+Hl8T1T7ngmRHCiO+aJnQwR
         u5vGSXC/tc/nfJEJF24l1KsaeJmzPjkQ4HiLKkdun1cEuYrasqSQ1WHZefPwtD/Knxaf
         iizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773063993; x=1773668793;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNZrYmR0hxM/DoGoq88/XwdM4xNmGaXW6cnlXqxFVCo=;
        b=YvpzvTZkKqdmVe39CU1e+DvORzBa+7n/YHzRmMd4huydYrYTV1Vy4oKsqzjdCMWd9Y
         JJEXGT1ur0TAwXbfQ8WM4eOI9DmKd3GFREIZAM8RGa4F/yNxiTCol4Vgg8r37qQ9ZXiV
         wLrdgQFHGQwPgqljrwUBZAHihb7FlpLnKlYwp/LqoIbbCJISpMo4PQlsEAmidsSGLqQ7
         UqIL09GSz9EuPg9gtMDm/WOK4xkboAzfK6J2sho0cKqpxAiY6qKJ+nSTp617u4YzID8e
         rKdv43zVDMIzuXPhSQ9U5grNrQQjN95jizdhvqEqEyzRzOgg7EDMDOD6YEs1oDLWScx3
         EuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfLdki2QESxotLdpDE7xcWSeXtc5/BnY6o4sxKcRt1UeDxlsYsl7QjYh35KFheDphSr7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXt5t3gtNkIHijCrX6hi4rerTJah5c497IPOn1WBPCydjdVfl
	lZU98Ys8oNjtvyoNVBn5dnvRRpmUWkbXN04tJGYx1ja9JZlW0M/ae3/TWqMEdzvkhb3PiQ==
X-Received: from wmg15.prod.google.com ([2002:a05:600c:22cf:b0:485:3925:a795])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4fc4:b0:485:40c6:f51a
 with SMTP id 5b1f17b1804b1-48540c6f65bmr12006315e9.31.1773063992500; Mon, 09
 Mar 2026 06:46:32 -0700 (PDT)
Date: Mon,  9 Mar 2026 13:46:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309134630.2638181-1-bqe@google.com>
Subject: [RFC PATCH v2 0/1] bpf, docs: structured overview of verifier
From: Burak Emir <bqe@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Burak Emir <bqe@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is an RFC for adding overview documentation for the BPF verifier.

The existing verifier.rst has detail but IMHO it lacks structure and
background. Here is my humble proposal to make the verifier docs
more helpful for newcomers.

Finding a balance between overview and detail in documentation is 
never easy. The idea here is to describe abstract interpretation and have
enough information that anyone interested can learn what is going on. 

Please let me know what you think. I used Gemini 3 to get a first draft,
which I then checked word-for-word and reworked.

Differences to v1:
* Formatting fix for top, bottom
* Fixed some wrong identifiers that I had missed.

Burak Emir (1):
  bpf, docs: structured docs for the verifier

 Documentation/bpf/index.rst                   |  1 +
 .../bpf/verifier-overview-1-abstr-interp.rst  | 74 +++++++++++++++
 .../bpf/verifier-overview-2-domain.rst        | 91 +++++++++++++++++++
 .../bpf/verifier-overview-3-dataflow.rst      | 83 +++++++++++++++++
 .../bpf/verifier-overview-4-pruning.rst       | 59 ++++++++++++
 .../bpf/verifier-overview-5-advanced.rst      | 70 ++++++++++++++
 Documentation/bpf/verifier-overview-index.rst | 17 ++++
 7 files changed, 395 insertions(+)
 create mode 100644 Documentation/bpf/verifier-overview-1-abstr-interp.rst
 create mode 100644 Documentation/bpf/verifier-overview-2-domain.rst
 create mode 100644 Documentation/bpf/verifier-overview-3-dataflow.rst
 create mode 100644 Documentation/bpf/verifier-overview-4-pruning.rst
 create mode 100644 Documentation/bpf/verifier-overview-5-advanced.rst
 create mode 100644 Documentation/bpf/verifier-overview-index.rst

-- 
2.53.0.473.g4a7958ca14-goog

