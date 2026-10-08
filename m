Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA484C2273
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471884; cv=none; b=ndbZUxsAGyUbABIHv9fkgffPqwzAyX9msoD/Bx30xGq+rcou2L6jRAUjrn5/GZePlHVc9v5UoY6JKOCUJd20VoKYBA82fikxbDekLyfy5wjBKPLf8ofpqZp3hbyCxE5i+xnR6q7uD95oxi0cXEhfooay9negHrQMa2ac4MNFIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471884; c=relaxed/simple;
	bh=MIN0yQszQ+nWINYdAJRE4QB/HBQcklNrf7uYZzSOgXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MIFPm9R5WRMV/jT3ngAw5+hbVdtFOXDWgmpkedjPcVM3ERiymPBvnDSbi9PJqqNa/BkDgheQVeU0/QO/srjHkAlLINdHe3aaDEh7rwVmUb6GnmO4Ke3z7DajLLNDCFznmp+AFzSRMZDNLfDsE3c1iBJlX3Se3jLjO+QGkzcQA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EaXsyWFS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EaXsyWFS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c14a06c95so2511707f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791471872; x=1792076672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lrVdfGfe0JNoSxkKZPcIsLdVTwOyR409O5kxL0DcF+I=;
        b=EaXsyWFS5GZi1l7WOXsVlCtMfSIlfNj6ofSkAPYjIqgBq06ishANeYlq77nEceomT5
         0vQ1xT4I4MJ1fTitu3Szzoiozi3wXw8r2pnRS81Q9ji27Hej3L/VQh0uyQzSTqTYzGqz
         zu2cXdlPg64En6fKePhIjrSBGiGr2TvtOhbj85MWldVd8n/yw7At8y658b4xaE7pT0s9
         xDuFhHGUxEwK09TAxbp3e1oq8wPu2qC/VGQGZw6kxAQbG1/gGgiHNN66PxLniFWIChRp
         1F3ioSgSd2HOgUabzm12j2m5FetvnkFCbk2vDufD5HbBlAfp9yVT8h20GDdcU+egGIYH
         CE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471872; x=1792076672;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lrVdfGfe0JNoSxkKZPcIsLdVTwOyR409O5kxL0DcF+I=;
        b=Fk3ZYFz6ZRHrO7jpzP1+uLD8kOzbk8B1BKpsRbWeGW2B7ogxPoUlgizh+PbQgpekjB
         HlAYUaqkg4SbbLwZrJCPPnopkHyPWfDNZEJxXOA48p3gJlOUPgYqpGxUZ760Jpvu8BAl
         6FneHtuZhAU/7F+Wbn1W+7nW1xk6niqxDYem4nyooUD+lCpB6ZFZhmB3joJXM25Psjtz
         QC1ulqQGRZzLXGmOkTdgZhoS0CdhUvycfNK6Lem/ycLZ5mmCR3LQ+704RB1WEngHKgcJ
         nyKmWSaLUOUDQ5GqYG90xK8mU4KmdKRhx9ee4hel3hrF1ueyvbDwQ4V5627+LUqovTaW
         DIRw==
X-Forwarded-Encrypted: i=1; AKwUvBymU4knXl+trrI2dzMw3HHFsJB66V6+toKTUU1YnDeFZo9cLF93xP9C9C7oYI1FFhQ2Jwg=@vger.kernel.org
X-Gm-Message-State: AFuF++nppHNV5HXPlEj02RrggZiu0QNFm1g8oCxDMMneTVD+qR+9cvWO
	Inu5ae/GLRmj/Y9rJ47Q5te+f4mzkI9E/6YKhSd/BXcNqWmHWlmR1iqHbgEBINEgbw0=
X-Gm-Gg: AYBFou16cAbtZtGlP1ZPpaP+4HAteYp0d5m1CLx/QoXbtwczbVOx0yhnkLsdZCRaC9P
	kUIIBDSKb6K9PfJ8RmxhYzSYkyIH+68cuH1pFd6DzIeGS9VOBPGLxMoYxNLIbNOstUuacU+EUPb
	5RcmScz7Wb/e7cnU4z6BDwYQ4jTws/foCk55/2tusNVFcR7mCvQ9ES7tfY2F5D32y3Lcj+3Ufu1
	U4LDs3hErG61zarYwIQrOVXseVWsxFjECC+n7PMx64VR0+SSDJzIgPYsHu0Hh8U/52KDU+N6BZt
	g5lX15TYEc3XSkKGn+knTR5tVg7wWz8CcvvRawYYVPr5AeDxGWNVLLB1S3NKfR5JInJCW2T1RzU
	1fc9P4QZqlwJqMVq0q2BtWmESZ8CvVrKGhUHv2xesW0Y7ymLDSkSeB4mtoZpVQh1idrDKtx/Uon
	seqAgCqj2+TnCzIUBW1f7USHnupf3LsOywqWJvHeajteUzjI6EBjcGmGYXlBIy0oQsE0ILc6WJY
	Rv6CUIKYGzXrEwA
X-Received: by 2002:a05:600c:3b9b:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-4a180420135mr122032655e9.19.1791471872332;
        Thu, 08 Oct 2026 08:04:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842abdb9sm72865765e9.6.2026.10.08.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:04:32 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] resolve_btfids: Fix the --fatal_warnings exit status
Date: Thu,  8 Oct 2026 17:03:08 +0200
Message-ID: <20261008-resolve_btfids-warnings-v1-1-0d4e613ffa6e@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261008-resolve_btfids-warnings-a356edc7a5c6
Content-Transfer-Encoding: 8bit

The resolve_btfids --fatal_warnings option is intended to make the tool
exit with a non-zero status if any warnings are reported. main()
initializes err to -1 and uses 'goto out' to return this status when
a sub-operation fails. If no error occurs,
'if (!(fatal_warnings && warnings)) err = 0;' modifies the final status
depending on whether any warnings have been reported.

Commit 522397d05e7d ("resolve_btfids: Change in-place update with raw
binary output") broke this logic by assigning the return values of newly
added sub-operations to err. As a result, successful sub-operations
overwrite the initial err value of -1 with 0, causing the tool to exit
successfully even when --fatal_warnings is enabled and warnings have been
reported.

Fix the issue by setting the final value of err unconditionally, so the
code doesn't depend on its previous value.

Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 tools/bpf/resolve_btfids/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 37d7e7224207..2a93517ca9ec 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1842,8 +1842,7 @@ int main(int argc, const char **argv)
 			goto out;
 	}
 
-	if (!(fatal_warnings && warnings))
-		err = 0;
+	err = fatal_warnings && warnings ? -1 : 0;
 out:
 	btf__free(obj.base_btf);
 	btf__free(obj.btf);

---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261008-resolve_btfids-warnings-a356edc7a5c6
