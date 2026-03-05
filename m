Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D635E92F
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772749337; cv=none; b=qD73fUugwJhdyBuKw2sC25zsx+XJ2AVnnGbhjdPeWtv3WJwFRp5V5EPlHBbEXMDZ9ygSJXgp3JKzFt8WT5P7eP4fvrudEBy3TnLySvlGDYNOypQUD0P8M8ai19CvyKCtpxYHpv+MsqkW8nghcBGVbODQBYuzoKXLMzgvdPLYiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772749337; c=relaxed/simple;
	bh=6KqCPewtq1kiJ361bvKaKNjRbb67s/elQW4tfah2P7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVhJSk/JPexu+lQi8wy9usq+5hLkDHsEwsDa8Ig++PB0X9zI9AgtLf1/t39bfsJALFKZAnifCCHXG/WjeZjxyOqqAVnE0X3qRUrJwF47nIVpO3myKzqitPGdso16EROkaa/gmEsBDmYxFNyw7LVA7zQcN0brLfkprcK+u3ajTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCoG4gLx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCoG4gLx"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2adbfab4501so38568345ad.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772749335; x=1773354135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYeE/zgQPJDLRLKshUZvrTFJR1CPgxz/WOMLSdHTUVY=;
        b=lCoG4gLx7IDymG3IHDEQG3H5ZNI7Y4c08Nz3xGlh2ApEryLNaSA9a3HqaTETy+Yk+6
         xXbTP5kegsjA3OfjS7cXK5UCvS1eCNqX3txDk6P823tjVbLXLnCC337q6Yu77ZB23WFA
         wyzWQ5VONMPlwV2bLAaJTEtIJaCsCfphuLr5+n7kzdoUftGwnQx0+KLmcvkB6uYUATWa
         8tOycPWs7Q4dJBxo8fcv78H3IHlsDebVkyxMhsC4i1b9wHwdI8O9Kwe2aLsXeS6YWXSx
         MoXM0YMk4fTDMgf462uTmh/YTx5QlAmzb+HOz12alTg59yKeRucC+YiJBy0L+1iSotpy
         HWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772749335; x=1773354135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYeE/zgQPJDLRLKshUZvrTFJR1CPgxz/WOMLSdHTUVY=;
        b=NEKNWNxvYFndUwXE9R3XLt+vl020S8j68IBUDtt0rC21U7xwZwvtIqj+K+pzyhkZV4
         xngrF0HN+luxVjGNiQx1fNN8u5T/Bbv7Bddnk6gw7ZpgZ0yu23XxOfJxEwpD5n7vImJe
         p2SR220ee1mm386ZPiwk/WbEycjrEmRs2klXrMR9N+u5NHRpN1HQh5Za0p5P15S8SOip
         3iEyjYXyjykFLX9hWNujl/ojgEdXwRnSN/ixA0I5aRRzPjYSqMORdWp89Xbo03BYTKme
         xtFM2a7h5GdNN4JMegNrtADxBRGvZhJAebj16ydicNTgi70nIgkoE2/63nHGXzrs1CVQ
         VOEA==
X-Forwarded-Encrypted: i=1; AJvYcCXVrzH5fB9WP3BMZ/YNDTzhO04RImsYUWixQe8nL80N5GrIACAh+rcXo0VWg/5Edk+3RXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbZ8mK/MbiFBqboc9TUy1C+rp2BbfopN5iNADZ+nbAKlGqZXL
	NolxmgxNm75nlek5WNIR4ky4tnKuzxghV0+IMpZmge5lI1Cl+ZcSpDGn
X-Gm-Gg: ATEYQzzJXuyCbpq9vhmNSqpM6Rp9nJa1gIcE0A0Pxw5SwRTSt0CWFUCNS2OpZY9RhbJ
	Pqo4oGw8sSCaEuQbkMSm4qfux56H2NwNrNfszZ4ysvEMUPILC2r2CtE3aShJrCGavIZB+8pMIXT
	kJZfD69+Nxe9Y3J2kl2elD5lt5ij4hBHBu1HlZaEHRDM1CMRsFJOaeU5rxAvOhHgRthKibafGwV
	J+qnYn+pM5Ld8YlhRrCMQJ+QJeTVwvlbUmspxZcT1B5+HLOl7d26y5fNYVpLk704payken8s0x2
	codZlVSVBcvY7xCWcw6PCpVfJNj6U81J6P1+zSKkpjJLIoueSvgErcTDX51NxTOQC/opf6ALH6t
	Ek9T/s+Ba0dT9Q26JQLhOc2bVVhaCes040EsFX9PKQ1hcjeu/gmu867WSfCwshqJILIn41QMY5+
	lYaZ6QCkVYYJNikAWDznkllqv7YdW9zvnr/P6rjJt9dEpPDT5fiE+WBqrO5CHctZGuRLNQ
X-Received: by 2002:a17:902:da8d:b0:2ae:5848:baf8 with SMTP id d9443c01a7336-2ae823681bcmr1026315ad.3.1772749334618;
        Thu, 05 Mar 2026 14:22:14 -0800 (PST)
Received: from computer.goose-salary.ts.net ([2a09:bac6:d7a5:11cd::1c6:11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f25esm244421305ad.47.2026.03.05.14.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:22:13 -0800 (PST)
From: Varun R Mallya <varunrmallya@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	toke@redhat.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	song@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Fix const qualifier warning in fexit_bpf2bpf.c
Date: Fri,  6 Mar 2026 03:51:32 +0530
Message-ID: <20260305222132.470700-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building selftests with
clang 23.0.0 (6fae863eba8a72cdd82f37e7111a46a70be525e0) triggers
the following error:

  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c:117:12:
  error: assigning to 'char *' from 'const char *' discards qualifiers
  [-Werror,-Wincompatible-pointer-types-discards-qualifiers]

The variable `tgt_name` is declared as `char *`, but it stores the
result of strstr(prog_name[i], "/"). Since `prog_name[i]` is a
`const char *`, the returned pointer should also be treated as
const-qualified.

Update `tgt_name` to `const char *` to match the type of the underlying
string and silence the compiler warning.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 23d933f1aec6..92c20803ea76 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -111,7 +111,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 		struct bpf_link_info link_info;
 		struct bpf_program *pos;
 		const char *pos_sec_name;
-		char *tgt_name;
+		const char *tgt_name;
 		__s32 btf_id;
 
 		tgt_name = strstr(prog_name[i], "/");
-- 
2.53.0

