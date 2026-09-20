Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF729CE9
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866329; cv=pass; b=QlXQLT9NIlgg3ZJuwCwwjFr8tJya1pZ8zLRLVljgpKnMx14dxqaUcKLrksxGSpo9D3/mFc33plRRezXTh4Na96LkNoIRH1uFD+wNFzmu7qi6CCKGEUIrbLRKuFKebpq0KNdnsiPdCevS9kXhFRmhesfadRawa6CJjVrpQAu+IPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866329; c=relaxed/simple;
	bh=NFivfYCAF6WzoAZvkEeMJ7W40uKcjTBrzmLLFRBodWw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pzh/n8KLbocYPrw4B5B8fT8mtHAmUQLfzBovRxMKD2XBwzqIvtLitLFkFGa4It+30VMPi3IVUv1PhAWZNNeefrawPLDhX/aKctCdbjLKp/58K4TvHOw5SRWGopDIDQVKmRVylK2Id3GMMFIoj2lWKSm4RQWQlJ3ZHdfJm9r624Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkcUQQqm; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkcUQQqm"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a64c7cdb46so2896897a12.3
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 18:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789866327; cv=none;
        d=google.com; s=arc-20260327;
        b=UtQw/r2wKR8VUmB3J6Kx7DhefzSxNC649n/t11oJeDsTa3zY27NdUAkV3hIk43o5jG
         L4ICGKsBKNgNluH2cidU/t1sb9lfCXC3xs1mwdHPoF2hXt/qtzHsDR1afIaj0kcW/4vG
         FC9cos9Vu4Fzd82YkKYZK60PioUJAideFK8ZHQYfpdMaAtXtCZ6aKl5RBEm7BVr8SK2o
         p9MAQfSyMYz1r65uH0bcBicwJ3Te0Sa71a1jEXHFv7Slm9C9QEpx6JiSy9qBDKFrqtvp
         fagpr2mGCMDWSm4M5IT2QjR8KT6HDgWkoxm39LtFX8IgTTak31kuOl+KlWso2A12unQk
         nmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=NFivfYCAF6WzoAZvkEeMJ7W40uKcjTBrzmLLFRBodWw=;
        fh=pOHn8TkHFejXkDE1ORfV2qrAzZm95uVchfx7g8VwDHc=;
        b=Tc9LSu7W5hHKlQX7W3S7/uEwU2eIuLRCSrnlDADXtRsAC4KDMKBpLSgk9jydsjJceg
         +GVEFLRPbw5sGFNpjdAzhWVNRsVauW3hU2kMYiVrPST/sRd/AdRBphonHSLTPQE49hbc
         1day2ObY1mS8pkvF9sWKpHwkEifZjBLbSevGU2NoMrluLy8xd4FEgk3XnJS1LeK6Gt7o
         +PPz4cJW+1bAk4sikHiZkdUjyjBLBbARhNkKvu8X3K/DTTe2H2i+s03NsG3w8t8MoaZ4
         y7zqZyHjbaew+F9rFm8r0tHLXHEA4eSm0bsT+5Pq8l4EwLvFYFn3xW/tKDmneCO4taV0
         1jDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789866327; x=1790471127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFivfYCAF6WzoAZvkEeMJ7W40uKcjTBrzmLLFRBodWw=;
        b=TkcUQQqmrXmajigL4ymUVXzgVzMfgsfniiweC8zQ4sDe/TQMRpnmaiZFRz7RnRR+rE
         agbH+5wFbgo4yYfMpx3mdH6C7kSiwdzQN+UqAaV5UTHrXK9VS0xVqtUf5uj+hi8667sI
         FlY3D4pPIpXU8TNxDlaeStNl7TVU8I2UHaL+0skLYh/4YP6qp0pw95eUM+7OtATga0Vi
         CIMK4By0WCJbhaTTgbmG2SuWh35/tG4XsEA1gp6Lo5l+pQi3U0Iea89hcqp9LSlcdO1d
         cBj9UkduyO2NbygdLz4NO/NHkUv6Y/auoBVFZb9wN3eprZKbtV40W7ZJlRCnVh9UoqAK
         krVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789866327; x=1790471127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NFivfYCAF6WzoAZvkEeMJ7W40uKcjTBrzmLLFRBodWw=;
        b=n5F+dZaCPFCQ5iNQAjFOEH+u+wTSe9+t8sIhI5EYoC4FBRhAje+4ZoCd8XKwdwwHS+
         kzCmqRwm2CCWcjFqCk/1QSyyZrfE3hs1lDpUEh6GpU14uZIP58kXVnbBUZwclUqo0C5T
         8pEd21OhH6To20iHQdEwsiIUv4KpFg9MMBCL/sBIC4OAJVJE4CO8X/f5fihKIsMAAO6Y
         3SX+0I0dncyroEXVYFW0IiKh437PgW9iIgFDSs1di8ZivPYdOXeEMDAxqnsNwPdBby4E
         wxDrDoDK1w9dNlGu7wAxAd5FCqFtv7qxnbln84liHvctO/YtIg0UhKaeSpWv/C0a0Va/
         z3Zw==
X-Gm-Message-State: AFuF++nmDIGzN+CWb8pzC45upUgbYJvunTJAbxUGmrRnjcFaZ3uYfaOU
	BcYhwB04TBFCQ8yIwOVi1OyRGvJpt9fYU9bUUm5O6TpfuelPnrP1+YaPpnyrbYEnEfdppEGWzIM
	XKf8iJChYxAg6pS3esVFU6/xpMi2sUw/jbCxe
X-Gm-Gg: AYBFou3zDZYuHHN31xm7ZPji8wQuGy3K8CUFvaLYNwfVYyDQ5CZfAAANjqtsCgPqit9
	E5WoNvgyziJcIk9NVLOK8eahIDt70rHod36j//k6zMalCzefEtH1UgDOa1OG9Jgj6VwjF4to+4K
	wRLiZulg5YqbmlDVZ6q0E78hPnZICF1JUdh8F6Aj1ZoBUD/6A3Ds8/cBjghy295v3nqHjEaJaCr
	ZqTXaDPM7TfvyM8lLZ0MTdG5Xrzq6q9Imo6ZiXo06l47jwxgy9hY8ipIRwlrZ4eC8Ljj3/VbnMc
	TDj6OKLmBgCPYAj3g7xk8tqGZwDcqWXeyZTLrk/Biv4Vvd4xgBIUqw==
X-Received: by 2002:a05:6402:4150:b0:6a6:7d56:7977 with SMTP id
 4fb4d7f45d1cf-6aa5686e419mr4607422a12.22.1789866326378; Sat, 19 Sep 2026
 18:05:26 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 19 Sep 2026 18:05:25 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 19 Sep 2026 18:05:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Robles <erobles3224@gmail.com>
Date: Sat, 19 Sep 2026 18:05:25 -0700
X-Gm-Features: AcwNN1XJoucD_suv2L2FflovLq3kBi756l3AhDrFl5_waj8s73I6QDvJXyL4hvA
Message-ID: <CANBsAxr6=Q2AB-NOEGyZohEXt7F_3wMzi5O8yw=fEUmuj5zFqQ@mail.gmail.com>
Subject: [RFC] bpf-lsm: scoped one-shot userspace authorization binding for exec
To: bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello BPF and LSM reviewers,

I=E2=80=99m requesting review of a narrow BPF-LSM authorization pattern tha=
t
is already running as a live prototype.

The problem being tested is simple: how can an external userspace
authorization decision be bound to one exact exec consequence so that
the kernel enforces the final allow/deny rather than merely receiving
a post-execution log?

Prototype flow:

1. Fork the child and stop it before exec.
2. Resolve and measure the exact executable: path, argv, device/inode,
size/timestamps, SHA-256, running kernel, and active LSM chain.
3. Bind those facts into the userspace authorization decision.
4. Only after PERMIT + execution_authorized=3Dtrue, re-check the
executable identity and write a short-lived one-shot BPF map grant.
5. Resume the child.
6. A BPF-LSM program at bprm_check_security matches the governed TGID
+ executable device/inode.
7. Matching live grant: consume the grant and allow exec.
8. Missing, expired, or mismatched grant: return -EACCES.

Live result on Ubuntu 26.04.1 / Linux 7.0.0-31-generic:
- authorized governed exec: succeeded
- governed child deliberately given no grant: denied by Linux with
EACCES before exec
- BPF LSM active in the live LSM chain
- governed / exec_grants / events maps pinned and active
- 25/25 local tests green
- 6/6 adversarial ProofGate cases green

The review question is specifically about the kernel-facing binding
pattern, not about moving the external policy engine into the kernel.

I would value feedback on:
- whether TGID + dev_t + inode is a sufficiently strong exec binding
for this pattern;
- remaining TOCTOU concerns between userspace revalidation and
bprm_check_security;
- one-shot/TTL grant cleanup semantics;
- whether an existing kernel primitive would provide a stronger or
simpler authorization binding.

Linux-focused repo:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate

Live proof:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate/blob/main/LIVE_PR=
OOF.md

BPF-LSM source:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate/blob/main/kernel_=
integration/scqos_exec_gate.bpf.c

Userspace launcher:
https://github.com/KnowledgeeKZA3224/linux-coherence-gate/blob/main/kernel_=
integration/scqos_kernel_exec.py

No claim is being made that Linux itself was patched, or that every
Linux operation is governed. The proven boundary is explicitly
enrolled process exec through the existing BPF-LSM hook.

Assisted-by: LLM

Knowledgee KZA
http://SupremeComputation.org
