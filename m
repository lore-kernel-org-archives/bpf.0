Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D73483BD6
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862962; cv=none; b=hSmM0s0Hf/IeCmNzaWdb2KskIhDa3ibe6urBXOKg8IHsox9MW1lhy/ls66b83p5rp3m6ZM0ZGU+32/+dsDqF4iq2uza1AXkMjt7yuoDQBlFL0oJb8QCBcCCRJuWZUmX6gC/h2cVEeAMXgkqZwIYzvTnrMwER6InF0m534D/lBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862962; c=relaxed/simple;
	bh=ujEuJrexQLuuwlorTJimqKmoljOBq7YjW2V6E1y1CLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cA0Ntca01aOHkdBl+queO9W82UdSrmra0UW25j/NQibFkmvd1E/dUUAJnJKcAkKXkWn6gaH0cm/qjbAM1hf00abjbR2zS8mZgPAoZGzdOH5RdWzZd72foMM8O/b2I6bOCzxSBmmwqF9imytQUgezkmTFuxlzk/oQtSg0SpYjxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbME+aQX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbME+aQX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so41173b3a.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862947; x=1786467747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8FJgXHUZq+MQB99o9iKOwVhSGBz4DqDKtV6nfky3k4=;
        b=rbME+aQXgrAYq91qu6thzTFNkVXQQxj8iKJjFpk783GH3hu9LNWO5uhwO4akgz1QBS
         ClJHtij4xQkE+HI6Nog+Jii2pWEtYlUM7wnKEKFsElcadpPOaez4C0u8MzNwUmZfMPbj
         W/eL6UVwb3kCfT5Yl+N/7/VB8I3ug6mxS62OCItL55PDlnUZEn+mjeEq+7bT7moniygl
         z6uKgYGRrKAhHuwMEBBHQvvL0ea7FtA//teGUydFu15O8vBrSXMPPzlsH91ikeplt0U6
         x5HyfY7WFrCagy+Nft0kyAKnwtPwLvEHzlcNIOVrhSiFh8fjkc9rU6OC9Dwk2ECk5fTj
         hB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862947; x=1786467747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M8FJgXHUZq+MQB99o9iKOwVhSGBz4DqDKtV6nfky3k4=;
        b=gfJiikLd46isbw5tpyDE7ABQ+AF7XkxzXZRO/NcBPK8TVytFUHDTn1AQZ0eFU+kOJX
         uQsWIzLCPsBXagaAd5J6pwwQSOA4q7bWGZUDNa9U+rlOa1wkIzqNDeNVWHLGNzQqTSMc
         jg4p7G+/TNorv8MkhpCikOYpXPMwPM569fJXC3lUUo6Akt3bCSng9YRVkbGCLmMJCPup
         Mvx214uSzJhjxO3dIUO81X7SmrWucSLh5QLY1beYbmMFk33/rXK5ppJLohbB4+rRR4et
         vYe1kBJULl1dR3reDsYyuGQMP/GOce2tDeCM3sx+DNgyOt79LzUVwJn8mnvyYtiAq8HW
         L4kQ==
X-Gm-Message-State: AOJu0YwZFQpcEQ2yvn17PQFBU9jLIMVNKAJGu/68nLU7YzU2As1ax1zY
	frT+V68UcCKVe29mPX3XR8h3PGZBS/+VZKcZntvgbK3hkJzdYRnz2g0YV/8NpG7GbKY=
X-Gm-Gg: AR+sD12hoq7DWz5MA8pQZh/YuJEHwCKrd8t1OowG0AfEO6EIVh3ikMpCbAJ8CzfRs8T
	7x/BoJAb5nhfXZCAaIG/Snjw8SEdWHgrLpdVUv7BeN0BPBuZzk5N7uluJ0XTnATQ7pVd2Ei5p9Y
	/7WzFhhTFgr3lTq9ve/8iYEYP+PehCYI7E6CowQmFL1VOa0lfja/h171VH/tCydcIQHfoXx45MQ
	w88pmkbBqxf4sTnpY3bD/wviJzhpFZd8mwmX9hpEcJ4Hrh37KJsILnQV7oylBkNnmly3Yp8HxfI
	Ge4GTkI9eJzq58cXb2Jvs4b3CDWvd4l0T26W5UN1n3Y6DKQpymGkeghbvRb7rolnAlbMtGgrUmF
	UMKCEBfjQAi5Xh86YJIe+OKoBWdS371luTYGcvOBLm5rAPWfPF3hqa/7nwy2v+AdLpl1ZUg4D94
	vhgtpbqtzGwoLMoS59QOOWP7Jv5bjU9DxzHiGEYhHqQzeuzum6L1XvyYHMgwsPeepV9oKJzcDTP
	0Uiv6KUJX4=
X-Received: by 2002:a05:6a00:3cc6:b0:846:f502:4cd5 with SMTP id d2e1a72fcca58-84f2e029baemr307078b3a.20.1785862947546;
        Tue, 04 Aug 2026 10:02:27 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e4d3926sm55508b3a.28.2026.08.04.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:02:26 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	nickolay.lysenko@gmail.com
Subject: [RFC PATCH bpf-next v5 5/8] selftests/bpf: generate verifier/tests.h in a regular recipe
Date: Tue,  4 Aug 2026 10:01:53 -0700
Message-ID: <20260804170156.1709916-6-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier/tests.h recipe is a $(shell ...) expansion: the command
runs while make expands the recipe line - including under make -n -
its exit status is discarded, and the resulting (empty) expansion is
what make actually executes. Turn it into a plain recipe.

Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 774286a55..0ee02eeac 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -922,12 +922,12 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 # them (e.g., test.h is using completely pattern), that it's worth just
 # explicitly defining all the rules explicitly.
 verifier/tests.h: verifier/*.c
-	$(shell ( cd verifier/; \
+	$(Q)( cd verifier/; \
 		  echo '/* Generated header, do not edit */'; \
 		  echo '#ifdef FILL_ARRAY'; \
 		  ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
 		  echo '#endif' \
-		) > verifier/tests.h)
+		) > verifier/tests.h
 $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
-- 
2.43.0

