Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7B2C21FD
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671483; cv=none; b=gFsXsA+F0rcnUEQpcgl9l9+LBPwgm+zqUAPFzOMyOl2PA8z4n7vzUSjh9fxklaw4J8dBjcy8aH+fnY7rhLMUWMcM9X6gLic5kUVSJEUyMXZePh5jr9TU+xtwfextDBi9LMTt9+pXh+IPUn0PTnIIG9W4mzEZWD5kL3fBrpvdGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671483; c=relaxed/simple;
	bh=hZuSHRUGAYgqrgHEZWJV6ET7MQlNplTA7eSKy928nEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jkMr8IeVfWdOLPvSg6rv6md6FpKoV68oeqniLgMbkKDuBSWe2YkyhloYo15icPUJ+9JOFW6WNw/c+VOo7I5R5myeZrzsQygYPbysJQH5unBu6ayJyPdt5ok477riMmVDOXMqL7xtRn8XlsvYG2W5krd3nqh7UQ4PB0LF7nAn3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWKVDjzf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWKVDjzf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48e82c23840so29938355e9.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778671480; x=1779276280; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XO40f/OA6RHf1TyE58duUa7vxILaUx/jjsluFq7aAwY=;
        b=sWKVDjzf11aE290rlxAqY9DHzmiB18PYAtnvEhQ6wl2ozaWGGAe7NyxUdPaKW8q37/
         HlfLckDuJD4PsjEYme/hY0rp9RRZ6bZnLurfhUKT8De2vCVgu7nUD+X0G4htSnjybAmS
         Q1o9yH2kx2RTZ5dJ0YxGt5j0LYCDORAGRkp2TzEQMtqLNSov61LZkNhDBN+lkKyKwY9V
         btZAzAuNxhp+J8ET9xW77j1l2IF4O5JDdc4W7xmYJAktbckZ1iDNvMQQFgCQ/+XOYtGp
         N75LMbUXyGNAWvZLD9Ctwiy8FL7MIZHOew25BUwSKsmusQJ8RTlpzC8fqHJxZ8RP4x8W
         YpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778671480; x=1779276280;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO40f/OA6RHf1TyE58duUa7vxILaUx/jjsluFq7aAwY=;
        b=T7cLAbm/mDUKcvidwzioLsar+/ztDcR56mhR1rUJcjlu8UANxe05uF1p9bNz8ILhO3
         VLqzaPW4Zcds3MsguFWp8TY9H15DNacm1HofUz4RiOlMF/nIlvoCzbxTEpOvnDy2/cHI
         6SopzT7Rvya48jZGaHsdCoFQJ56GjqsVsh7iE1yjeEnREXH8jFsy9F5AgG8cPi8xD9I7
         GTXjiCOfrXtzTNhoMvGEeSfJ/hnarYg7uA69trirwZLgfV3Mo3zrN/3WTtkH1jZPI3BR
         QRkv5rAWIYZ3/SpGVlsc1zD+oEkuqb/IMVtK32C+86cNI0B2GgesX/cpf8s98T42OPJA
         eUeQ==
X-Gm-Message-State: AOJu0Yz2uhoTHUpFa6Dyf/jUK+9hm00HuZNa8StiHSpl41sibj1a+ON0
	hY6plPBlxwmu61vqNO9lTiUTvnqT2fmEG/A5/9iFL6xQh/R19lfRIUvhAQ2RuA==
X-Gm-Gg: Acq92OG4WIzFIfXWM7nwPKm965zCUlkVBGW3lokQXXwmWoN+1olg4HJWlzci/lXMeIf
	m7aqI0lRnke9XBCLZzqyOC4t0cXyZg7bQgGkaBegmKfgSeC6GJ4bbPE57zxLLwbo/ey/qPIbjct
	tDjbrQPTPYq0Ct5w+oRvVEG+d0kaEHp5oPAY3Vm5buWBN1rT50JgfqhVmgIUokORzqIY3PN8mk2
	62hZ7N79y/7WfAZmkKSSRe9iuLNg9Skvp5BXy5BM4IPnhDnU+uWUJqq6LFiBWt8JvoByyGr4WLp
	cxjZDWhucQsZfdjjctN3HcPDJiQIMt6slfSy/rAUlxU+r92/AAZAvWa6I3tJXvubiLRbOmNAT1G
	IR1iDTlvNLWZS9F+90Zgo1+cRLHgNDeeqAwKYfWtBPRSNhDS79BtY1FcdK+DCTgOmh7Sew6SZtZ
	oglipYa9z6yGRtYNnhSYTThcx0lmiMYm6Ny3Hoi7yJGb307Y4McBvCVktJspVK1+ixaFNKTL/Gi
	0ueHaprslkrPBtfuA9h/3DZVnSbVOpLDrsXh4JyWH/PRHc87xwnp7r/r7Kt52DPoIBNtiBnQ3k1
	CtQ6RM93aGkTk859KbByz7PaR3HeND/+JljN0Sw5MNk=
X-Received: by 2002:a05:600c:811b:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-48fc9a2cae7mr39550405e9.16.1778671479886;
        Wed, 13 May 2026 04:24:39 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce37b182sm69650685e9.9.2026.05.13.04.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:24:39 -0700 (PDT)
Date: Wed, 13 May 2026 13:24:37 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Override EXTRA_LDFLAGS for static
 builds
Message-ID: <714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When running vmtest.sh with static linking, the bpftool_map_access
selftests fail. These selftests are calling the bpftool binary in
tools/sbin/ directly, which results in the following error:

    error while loading shared libraries: libLLVM.so.21.1:
      cannot open shared object file: No such file or directory

To fix this, we need to also build bpftool statically. That can be done
by setting EXTRA_LDFLAGS=-static.

Fixes: 2d96bbdfd3b5 ("selftests/bpf: convert test_bpftool_map_access.sh into test_progs framework")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 776fbe3cb8f9..37164322a102 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -77,7 +77,7 @@ In case of linker errors when running selftests, try using static linking:
 
 .. code-block:: console
 
-  $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
+  $ LDLIBS=-static EXTRA_LDFLAGS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
 
 .. note:: Some distros may not support static linking.
 
-- 
2.43.0

