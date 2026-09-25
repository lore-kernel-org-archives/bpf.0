Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B04D8DBE
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353253; cv=none; b=l4aXU8w8Z7GKyWrRNfEVDvZFs7KMCFn2sp0ZPpQjkDQt6994Jk+z3vGnkqPtcyOaiPy5/V7G3ChVaR45t9DfhyRGR5k7AA7pD6YYaji8eYCOyyF9YlmI4hbq5MnnNsvwmM07gspG/dr0VeS4grERLoA1BfQRYVMJw5OdodApCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353253; c=relaxed/simple;
	bh=U2X/YCPxhZbpRdynV3A37p4jPBJOoV4pvy5fFqhacLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGbs/+HyWAIA1gFC2GqSlu8tNjwFOHoHrp+f/D96oBV6iqJK+W0n/9tzdFkpv5WfnJRDQhcXsm60LNuzH6Po25jYO3uadeLVlBj8SqYKg+B8BdszTm/sXbAnrocLepTItF10CjTIXiapLl2DobB3aTlMLYvmjHV1FPetPk225xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNbyyRi4; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNbyyRi4"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8e6ec4d9bso752969e87.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790353250; x=1790958050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HgPfNT8xWrXDVXC9NqDHNFfJHuKRQrWSe+UtPZZT3u4=;
        b=kNbyyRi4wFfSMSJFmZW7YGbcx546TVka966MEgn63wMQiaV1qEyTlscK9sApCWaPjv
         A2O51LhDBYRVER4hL3fAjoEujmx+8IiCLVhPPXfa5ux8ILJcsn/4bFoL/s49xjyqvOEm
         6HNL0N1Iz7CsGbewz6HvoA9FDPvC3rH2fczitpeKbtfRKdWEj0IS9CdNUlQ3ucBu4KRE
         ziZVuGQsgRu19SVOU4ypm7azBu2H7IrAvnszqaqVckgpfmH0gTkLhT1Q72ccdWDuIWqZ
         Ud6Jp+FQNrBj06640mbDrAy5gjJtd+aF4PDltu8rEX8UDIEoyDEqLgKxbwQ4Xg8tfNt6
         MzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790353250; x=1790958050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgPfNT8xWrXDVXC9NqDHNFfJHuKRQrWSe+UtPZZT3u4=;
        b=L3UQzhB044TKuhmdj7h/0rzAhyTk7bNXWw/+Ot6rd/92T3RqW9HS4AjSeLIqm2nXAN
         HzB+Z//msoDXweaqB6u1lejTlpltaDyXIqBI4/+V92NTKv/tWqZsvs+2wNIVL/I60Wc5
         Iol0ditQnpgS5LefqFBPniaImOpkUN+6bP2aYYXztoEnidFBbvYOraLbeE6cYMwDnsiK
         4FmevOFMtdfj/l5YqtxYfERAa8upQt0IjELciEsrJnSh6p2BdmYTs7mOIl+wfnxDn7fW
         zWQ3siOiXB1tdmOvFYVON/U/TwoQ3bDkNzDCLMuSefMjpXNfh6FjkfE5mFpNJ6sSIVyA
         XFgg==
X-Gm-Message-State: AFuF++n9VkwmSJ0qSJZFisTWgKmkz4B5MyCFX0ufYyq/x1ZX6Lm8dXQ5
	UmaBs+JwsXTDFOIhZ5Fs3OF2iWg3In/Fp/zUUW5kBPgx/SAo6WQa48tMXWjjPjdxOUt+6w==
X-Gm-Gg: AYBFou3UMTyyzH/pEZ/VvPqV5SpRIEJ82eSyDNsys+tThMw6BpkC9o6PI2jb1Ngctji
	8r+pn6xqTbh6BI3jzGA5g6/9Ct1/He2U/vNPH7TeybNbj7ePY1qkL8XWVbC2cHMo263eutYkHBh
	p7dROroARaY6BND6WwQ1KLEekpUE7KJQmutBjUvAyimiiaJ8IJMatHrmFcQ1h8tsp3s//gxw2s6
	ch+g20ufwvxQXgMvORYUHAg6OXFyDkcLRlkl3X7qHtIBqi16t7D0scKqCuktmxHXwp+3yPBNlml
	NjI8pbxju0mn6dqukuAdkAhk+nNwpcpqRgZGdEG3/f2s9KIqmAVn0ZI9xkUs4z1nMHRseDP/ZoC
	8Ow5I56xUXERpyq9vJOpY6fJuEOhDAB9hxxVtX5mSgaK76TAiv3gvfmIW5khvqaWjoyqDyTYgbN
	0q1SXJzosaq1AxOdpsIlKmSJXh3ximy3tx+Li3itR7d/h2q2E74K0sqUYPFeJUY1dORwladU95t
	+VXEOi3K/ipK3v1
X-Received: by 2002:a05:6512:10d6:b0:5b7:58c6:d808 with SMTP id 2adb3069b0e04-5b8df0c6a59mr2202778e87.35.1790353249789;
        Fri, 25 Sep 2026 09:20:49 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.66])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6ae62d7sm655740e87.20.2026.09.25.09.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:20:49 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpftool: Fail map dump for maps that can't be iterated
Date: Fri, 25 Sep 2026 19:20:00 +0300
Message-ID: <20260925162031.27259-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bpftool map dump" treats only ENOENT from bpf_map_get_next_key() as the
end of the map. Map types that can't be iterated (local storage, ringbuf,
bloom filter, arena, queue, stack) fail on the first key, and bpftool
prints an empty dump, "[]" or "Found 0 elements", with only a non-zero
exit status.

Patch 1 asks for the first key before printing anything and fails with
the map type and the error. Patch 2 adds a test_progs case on a socket
storage map.

The new test fails without patch 1 and passes with it; the other bpftool_*
selftests pass. Tested on x86_64 under a bpf-next kernel with KASAN and
lockdep, by hand on queue, stack, bloom filter, ringbuf, arena, sk_storage
and empty and filled hash maps, and through BPF CI (x86_64, aarch64,
s390x) with only comment style differing from this posting.

Changes in v2:
- probe the first key before any output instead of printing a hint for
  ENOTSUPP only, so every non-iterable type gets an error and stdout gets
  no "[]" (Alexei)
- drop the Fixes tag and use a neutral example map (Alexei)
- selftests: check that JSON output is only the error object and plain
  stdout has no elements or count; clear the output buffer before each
  run (Sashiko)
- multi-line comment style (bpf-ci)

v1: https://lore.kernel.org/bpf/20260924160732.485650-1-skokovmaksimevg@gmail.com/

Maxim Skokov (2):
  bpftool: Fail map dump for maps that can't be iterated
  selftests/bpf: Check that bpftool map dump fails for socket storage

 tools/bpf/bpftool/map.c                       | 26 +++++-
 .../bpf/prog_tests/bpftool_map_dump.c         | 88 +++++++++++++++++++
 2 files changed, 112 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c


base-commit: 4f3a5eae895b9995e93425a75235d8f1f3268caa
-- 
2.47.3

