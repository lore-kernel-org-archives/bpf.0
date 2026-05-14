Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375C33FE0A
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776470; cv=none; b=o344D3Qu5cUiElRrg21AEXoZj6L2AmW+lu/c1Ej9yyL+PnK7tEHkfOYXjFk38Dt67hSA6XwSGrclr0J7UbKudHARuc5IStDC9QOT2lAtTBg49XvoPWqj5ipn9WWAyCMLYYV0OEmB6TazWKjJx3MVy9MwPO5X0MJDvc6fDuRpfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776470; c=relaxed/simple;
	bh=NmwC00d0QWQWGqBtMbAJfgXctOaRXmTkUV/Rmk73Ex4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LE6AOzqq9gPVfNqKGvRIpUhGFtZXBgj7pl8Sq9p06jyHudiah2cBwjqTr7Yd5kCK10iNPFNhViKn7xRyClLHosPcoRFuzWMCv75RBk+iWq2qi3xbKqonDDCLYjYEHoSRkdmrcpmfON3D7Jnkq4WsBd0wLZ+5hu59gEkZgBnPwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwSpbnf+; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwSpbnf+"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132a8f93432so5846355c88.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776468; x=1779381268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aNoI7BbnJFryPpWBQvv00Uhu0X5ziO6QpZKLc8J78U=;
        b=cwSpbnf+GfHHNPFmPozjTBeQH8igQBSm1o77iWPF95NW8qxVax5QkRgto4VdE0dvJU
         ADatYnATYFlfc5AxEzSzL6O6SagoHlbYQ9H+2MmzqAsUINrYYciUeq6fLOTDQW0blzT/
         hQoCZZXQAdP9WQ3KdBIZem4gNhYq107sLei/KaoudO9yh5Bg8zBuqCpMOSpk6iP0B1ds
         lFxl4SzoPRhJGOqs4haCSrrNuECI1Sh35CxlSAhCclR5NGlgrxm2y/kpi4jXeiui6noq
         cSCz+aa3bBulnmKH199/scLz8l0zChtb4chy3eAfIz+7e77VAQp/UVQy0ArCWsdcIXnC
         4FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776468; x=1779381268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aNoI7BbnJFryPpWBQvv00Uhu0X5ziO6QpZKLc8J78U=;
        b=kogC5Q1zkXGaUMpxdbX8BoEsnYHtGl8PQX0pZDcCugBuBrRUh56RC4q3DEHlHK72nT
         c/wAPxQSnE0Fib2xCNIx5TYW21YZzV0Y6g7GW2y1FzfvvoDDr5dzsVbdimZQQ90I1NvN
         BAkM0PQ0hlC7Ka13WX/fYk60CWf70ewJUH2AiYZ8BVkzsM2yOI2uBYHp2kg6cGQA1uSc
         RxFZqRcgF7OqoZ8/aGs1YFCVUUJ0e1xzfQ1MUWKjW9UMsk1+W+PGrDF7WlcQpkbU/gbw
         b0JPk0VByY+bSYzWoY3uL/U98YmDLR75yx0sx4/ShIC0WmLFWaYD9npkyMp5lriez3MV
         EYYg==
X-Forwarded-Encrypted: i=1; AFNElJ+pnGFmCYEbs9e1xgOwOIrRB/YqNYwWqhxqTrSpUyiNGM9bft7RfmuaCsOHaV94BDgwErc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYtgf2g5kjDSlmgTU2tB5D2duqq4Nj/x0q4gaaLJw0J3BQ8G3
	3E8Jqxk0BnmRFTfvwEwOXROHbmEI6R3PUaKEh4qzifOxvpGIupYbnGcxzTA2qYxB7oUa9a9m8o4
	reky1cZzUlg==
X-Received: from dlaf13.prod.google.com ([2002:a05:701b:240d:b0:132:f6b7:e3c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128e:b0:133:3bb1:8d41
 with SMTP id a92af1059eb24-1349ab4b325mr4887099c88.28.1778776467779; Thu, 14
 May 2026 09:34:27 -0700 (PDT)
Date: Thu, 14 May 2026 09:33:55 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-4-irogers@google.com>
Subject: [PATCH v3 03/17] tools build: Fix test-clang-bpf-co-re.bin to
 generate target file
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

In tools/build/feature/Makefile, the test-clang-bpf-co-re.bin feature check
compiled test-clang-bpf-co-re.c assembly on stdout and piped it to grep,
but never redirected the matched output to create the target binary ()
on disk.

Because the target file was never created, Kbuild could never cache the
result of the check. Consequently, Make treated the prerequisite as missing
and continuously re-executed the Clang BPF backend compilation check on
every single sub-make evaluation during build startup.

Redirect grep output to  to guarantee the file is created on disk upon
success, allowing Kbuild to perfectly cache the detection result and avoid
redundant sub-make forks.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dc828523b50a..c34faccdf28b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -385,7 +385,7 @@ $(OUTPUT)test-libzstd.bin:
 
 $(OUTPUT)test-clang-bpf-co-re.bin:
 	$(CLANG) -S -g --target=bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
-		grep BTF_KIND_VAR
+		grep BTF_KIND_VAR > $@.tmp && mv $@.tmp $@
 
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
-- 
2.54.0.563.g4f69b47b94-goog

