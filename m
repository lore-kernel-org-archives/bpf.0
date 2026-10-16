Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83210328616
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117217; cv=none; b=HqFcgN4f1YQpgshnL1JbYHs9vnOt2FcsSWhVbz7L7PVoj82hbnPZLWiwIc5owE51dnbji5nRLLhIyTr24e2ZRWzkx2RBHE7cR5/5u4qXV6BIIdulxksPZCAwht8Qw5NaK4AAYtswqwNuC8uTj8QhZty4lZB6ojSRCqMQzOJukAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117217; c=relaxed/simple;
	bh=uMNUe9ZHkRV/QimzWs1Y3lfx283d+iaVib+qDCbrxJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awPKZuWFg4BRMt9GXfKz+BENMiVC7zBchTJFG8KoO08KAhHf/tpWlQPbDGL6EjfFg13//zUaCzjiugC2nX3ElwNkmFPB5zNOzWhZ6p94MOtbAAx01OmPld8Ug9mArX2VgPY8iRirqO48/vT3WJqrxZm07Q8mu22nLJLugqtirYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=P7kyhPA/; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="P7kyhPA/"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-141395927feso11463077c88.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117216; x=1792722016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMNUe9ZHkRV/QimzWs1Y3lfx283d+iaVib+qDCbrxJs=;
        b=P7kyhPA/SUbcMqTpYArePGIOW6HzrdqGoTTNVr2hHY8hgq+5uOyx2zaDXZLQKYvUtc
         hkRD0NVK8FiCu6G89YkM5DDSCz1DVSIEDXWv6izB3RNA+thMrNhDNKM1kiniwDwK5Gig
         1tboQPOFqMAz/A8CKbxLK6OlB1aPh/jKhugoe5In0E1HXTfkXIUj9VjLH9dDW2hvBT4r
         U2ebC0uVCVu287AzDV54tWaKGzjUeufAaKQAva0zkrI44iiNYNgjGq7IPszdR1s1b7sq
         fgy1h9SKtUHhmoS0+D3UET9BPyHs8i/wsTglOpJdz0hnKxGA8KJjwZImDk9AFXGmmJsJ
         ZeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117216; x=1792722016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMNUe9ZHkRV/QimzWs1Y3lfx283d+iaVib+qDCbrxJs=;
        b=dmLdH4+2Ln5Pom8lWYgPAAGoX0MvdoDNzqY+zdLW+AOFw5DpJ1gwNsRUok7hrX9qsz
         IN195cBtrGfyzt9CJfjBSRY8T6ARydWU/fwSApbvpnQcnRWr5oqlg3l81+rCeVwBnHIM
         v5nAu8OtWzuy/NSg0WKKaqVOJdbML3QdiD/XGoFoeiL0fsjkta+KYA9P9YX2Ny4n983S
         W081h57DJ9FjF/BR7sZNHlfnr3sYRdmj02XJ+5Y2SuCkimXyv8waoFPiW4B6e+33vUks
         rHQp9wx2cnZyIIlNeW4nLu+dCtl7H2x6I1Z/x/DyYXSURKhEdyGI4jBxBbXbRxOMPDkV
         hOkw==
X-Forwarded-Encrypted: i=1; AKwUvBzD7cAuIVLLwlNbM4IdHJ3MiXXaNfElEaHere2J4SZ9I8e3usQGW9OX1cIwjvqPXh+wKPU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfBdpyzq3K3qeSXtC6xhwSy8zNxSbeEKexM6ShFsqD9ss4X7lz
	diPWSx+gk/dWVKIbH8I++qJ4oI/SWBrvfzteKY/izJBy6Y8pH3q8IyUss2rWlaqOTk4=
X-Gm-Gg: AYBFou0wrJt3ddhld3Z4cnqylC+M5trRHJBUMV7iVSWSIJth9s6oyy9+UaghBBN9oEO
	9F7XFlNRXg/mkvJVlNDP60YZAMuN68TZcfpHx/P0ERMl3awG5BdV+KRE6wECwhChsThmeLRht+u
	4DXuvyr7vlPIMqalZel4km7U8GRE9C3GJ/Cbjorp/lEauzOMyuLD35h9qQ8nyjRlAvtbF86F12C
	zMLw2VHBYiLvZ4JkgYPxDKlvN5Hwx+lELVpNBlxlVY5y8CmbbTxHjpXegjNQ1t0x3ok62W2ZOKj
	7O2AdzpeKqdNKxpP/7Qw7IMRq9/WFRYeCVcwYrtj0AqWOmQudOf+/vkb6EnBVNJAhpvwL8K8FYS
	7g+8yLZ1fvq3SYIWcVMbDKG0CoT3PHQ7BtXhV3EhBBzyXkC8rPvozskn3fe+2MWcx7qIHnjoNte
	IkVyXs4MJoEJjCWfXbSP7XNnW7ntF4oVkW2d4tKFPWRsoVydV/FZ3NiURBVNxeaJLv0o2rcYuRt
	eoyfWGJTVB4xGhKmRmQ71qu2q/1mXLYixkoRfYKmf61KPhaXdC4Devbcwn/g0KbZjkdHg==
X-Received: by 2002:a05:701b:42c2:10b0:146:85b9:970b with SMTP id a92af1059eb24-16a610c9bc8mr34000984c88.39.1792117215179;
        Thu, 15 Oct 2026 19:20:15 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm1434734c88.22.2026.10.15.19.20.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:20:14 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y 0/2] CVE-2025-38060: backport fix series
Date: Thu, 15 Oct 2026 22:20:09 -0400
Message-ID: <20261016022011.16938-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2025-38060 to 6.6.y.

Apply the patches in this order:
1. bpf: copy_verifier_state() should copy 'loop_entry' field (fix)
2. bpf: abort verification if env->cur_state->loop_entry != NULL (correction)

Patch 1 preserves loop_entry when copying verifier state, keeping cloned
loop states consistent with their originals.

Patch 2 aborts verification with -EFAULT when loop_entry is unexpectedly
set instead of clearing the pointer and continuing with corrupted state.
The code changes in both patches are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
