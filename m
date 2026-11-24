Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525447;
	b=3+X7gSJ6+SvhahEj9TkIYaU8ieKKL413whm0o2UaD7m2fZxL1YrKSQRNGQjUQZPWD+Zl
	 U1PdoImg7fU9OFuW1Hy5KcQ10/ti1S4DnsSvHywhbTNyY+sxawO6Ls6fZWL5n7HWB8bfB
	 0E3SqlGBXs8+jZYclpo5qrqLPk210CScoYyHpFz7xBM0es8OrIAzmCcNZ67/wVvBjZBmE
	 X5K9W06ESPziCrMzxPJbVupe94Uie+i7ZpyvV1TwfDYMp9cMTuaUpsj5RTnvLW4bu+MFD
	 p5+iVeIniKSusmFKNazf90RHHFic76WELuwpCP9/VKNJYVaLEAiqRve4YACurreje1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+rKxb7dU0UMEzCyAusf6VPpzW2HyfM8DXyzbe16sF6o=;
	b=Mf9mX2S0Ef2Tblg6OsJGJQ/l3M5oV5oH4m9pTW5fLyDnCzfYW8Si7lT6bIQErC0GM3pJ
	 ha84Jjo7QLjzIAu/6SeBBjbvyYvSlOL32NhKzpiUzq5eGN7IBNiPAuzdzLmGQ9bE/3Vkk
	 qsyAl4TRL0Wkp9+O3O9njmxs5hRxPo2GyUb2bPZMi1sEaLX+Xf/iXHaK4kKy29aUBYHfH
	 Lq0zSxKSZQrFtWb95vsWoW4VRTI/nU6UAbdD8WJHWTGFYUdtHK1kNU0zvgsBrWXDlViDT
	 3qpFcCojBYjJnulf7DVq5YYD0PohkFUR8BrI+EtCEl+VcHgAcNz9EL1nk40vdgq12jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I+N/sQ09";
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8B606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC8B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+N/sQ09
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so2282084b3a.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 05:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795525446; x=1796130246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+rKxb7dU0UMEzCyAusf6VPpzW2HyfM8DXyzbe16sF6o=;
        b=I+N/sQ09fQuEQXJ9fyOuMfHGIQhhtYbdQQDKkIKriD2d/WQsO6T3VxQv+IRpSS9W3t
         bQGCb0qtr8bc94vBDzm6kOAtFgmzqOZM/i8oroHGAXR0hGtW4Fj0cq35JB6NhDBmS9uR
         x6oA84jtUd+1jvyOWLoWa7vEQg4euFUJ5LIUMvKnt6q1UanGPTNGcDMRvSPLsGXg85XO
         DfZ6uDgXDyXj5wJOD9ClSQPEOsLjpfg2Lu7q+2nmeVjyHxKAp/xQOItLtJfwKWmzkqpQ
         1Fe8CVOcnYGT62DLvBRxI5bIVljfJX1fc5sJuR3bEsOaCQ3H/dYavYYb2aPjl46jbpbr
         VqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795525446; x=1796130246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+rKxb7dU0UMEzCyAusf6VPpzW2HyfM8DXyzbe16sF6o=;
        b=kPXfttOKQiNvNeQDsC8RRAGWRAr9wazKKU1FXd7mQ9WTxJ/L9qrKPvLPU5nG15rhWP
         6vwzLnXGRVYufTAFEGASHSvlKjwVgwL7uQts+UosdrQGk+hmEJqxnAe1Ec/ViZF5tPjx
         7dot+OfmttVu7VFJc/qNa+YynVNJ+7PIFv4DcjWZboIfwEHtp+prqX24Z/f8QJuZtKCs
         iq91efpfaFPIz6aXhbK0jyQh1QFGPN1ZGye9pE9eedQy/cEao6mAOQabg9SZR6t8QrnV
         LWdoyDq2mwLiygVziah41PcIiLwuGYWofAX+LuPGkPj4dfOd3JmmzwoSaZtdEElsQ2ho
         f8vw==
X-Forwarded-Encrypted: i=1; AL+hErGhS+76mqVZ8X09C3aQklIR01S11Ka6voiQAHaTLFxWyzmCfx3GkKgZ0Zd/1wT4USd1cO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9zPcqmJcIpWbrW4FmCZ9iQA6j/u6gOxj5HOZfg4NhflQkjT3a
	xGN1qehqDzHwxo8XIZeT+h9/U0UEbFMYlN5GeeuilW58pVRBHEnh6L2+
X-Gm-Gg: AZFdTZdUAFvW4iujFKPWZg7j5+6wLTYULVVDeUVBFCIdhgp1MeXEJf6yjsHLnVfZoU/
	DL2SYfpNu9ybMdZC0SYVB3Ov+O13BxEdXOHcMtsxx8GVG4I5YKOxwzAYt1xrrrPHfE+5pXu807h
	Z72XKhGW3YgIt0cW2JanXibTLF2Gq9HCke6s8mAoSCm3xbTFhnVQegzzHQBZSkAdC+4eNcJMbr3
	t1316+HQiRuhlepNr0m+Ql9UaDz31Qb431RFQZhpBWHxZ4kz8VYbqaFoXpGwZZ28S+Cpln/aXYZ
	fa5HOlj+1R+57g2Nd0jFTK3kJzFdHyPAWZSzWoowEVFByNyffRDcanaAUBd/MaxdVCBNaLImPCH
	YgkdIKDjycVgF312GUw30fJ1s8t/k0gUANUMRRjXHL5tBfOB6roMLvlSZDht71+tdzLKV3f1ryj
	j158gC3A8FS95l+VbU6gZc2MVYNHVtP1dtar4brzuwleUKscdYTvuJilW0NhZu3hav5ZV1gtvg+
	ECfcaiX29kXDSpwG5VLRMNTjfRhIdg8X0yOqEoAgynltzG+buFpDBsm0ST/GV4uQ+cQY39PKC9g
	OY2F/44d1J0ehR7TW/5os4u0cxgWyY4Q4Dgk1h3pBFIaScChnMlVTo/rrpjUB8irC5XbNq61/GR
	aW+kzPgy6tbZv
X-Received: by 2002:a05:6a20:c992:b0:3e1:88d6:60e6 with SMTP id adf61e73a8af0-4014a27f154mr12795163637.10.1795525445647;
        Tue, 24 Nov 2026 05:04:05 -0800 (PST)
Received: from d20be28ee783.tail196be.ts.net (vldb.skku.ac.kr. [115.145.173.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm7194090b3a.31.2026.11.24.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:04:05 -0800 (PST)
From: Kyuwon Cho <kyuwoncho18@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf] xsk: keep the charged page count when pinning a umem fails
Date: Tue, 24 Nov 2026 22:03:59 +0900
Message-ID: <179552079829.1290967.12345053263834529704@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_umem_reg() charges umem->npgs pages to the user's locked_vm before
it pins the umem. When pin_user_pages() pins fewer pages than asked,
xdp_umem_pin_pages() overwrites umem->npgs with the pinned count so that
xdp_umem_unpin_pages() releases only those, and xdp_umem_unaccount_pages()
then gives back only that many. The rest of the charge is never returned.

A short pin happens when the tail of the umem area is not mapped. With
RLIMIT_MEMLOCK at 16 pages, three registrations of an 8-page area whose
last 4 pages are unmapped leave the user able to register only 4 pages,
for as long as the user has a process running.

Unpin the pinned pages directly and leave umem->npgs as charged.

Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260421172951.A7052C2BCB5@smtp.kernel.org/
Signed-off-by: Kyuwon Cho <kyuwoncho18@gmail.com>
---
The issue was found by an LLM-guided test generator that we are
developing as a research prototype; Sashiko had flagged the same leak
in its review of an AUTOSEL backport. A reproducer, which runs as any
user:

#define _GNU_SOURCE
#include <errno.h>
#include <linux/if_xdp.h>
#include <sched.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <unistd.h>

static int reg(char *addr, long len)
{
	struct xdp_umem_reg mr = {
		.addr = (unsigned long)addr, .len = len, .chunk_size = 2048,
	};
	int fd = socket(AF_XDP, SOCK_RAW, 0);
	int ret = setsockopt(fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr)) ? -errno : 0;

	close(fd);
	return ret;
}

int main(void)
{
	long pg = sysconf(_SC_PAGESIZE);
	struct rlimit rl = { 16 * pg, 16 * pg };
	char *a;

	/* no CAP_IPC_LOCK, CAP_NET_RAW for AF_XDP */
	if (unshare(CLONE_NEWUSER | CLONE_NEWNET) || setrlimit(RLIMIT_MEMLOCK, &rl))
		return perror("setup"), 1;

	for (int i = 0; i < 3; i++) {
		/* 8 pages, the last 4 unmapped: pin_user_pages() pins 4 */
		a = mmap(NULL, 8 * pg, PROT_READ | PROT_WRITE,
			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
		munmap(a + 4 * pg, 4 * pg);
		printf("short umem: %s\n", strerror(-reg(a, 8 * pg)));
		munmap(a, 4 * pg);
	}

	a = mmap(NULL, 16 * pg, PROT_READ | PROT_WRITE,
		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
	printf("16-page umem: %s\n", strerror(-reg(a, 16 * pg)));
	return 0;
}

Without the patch, the 16-page registration fails with ENOBUFS: the
three short ones leave 12 of the 16 pages charged. With it, it
succeeds.

The patch was written with LLM assistance; we reviewed and tested it.

 net/xdp/xdp_umem.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index cd8643360eb3..15ef424e2765 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -109,17 +109,14 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
 
 	if (npgs != umem->npgs) {
 		if (npgs >= 0) {
-			umem->npgs = npgs;
-			err = -ENOMEM;
-			goto out_pin;
+			unpin_user_pages(umem->pgs, npgs);
+			npgs = -ENOMEM;
 		}
 		err = npgs;
 		goto out_pgs;
 	}
 	return 0;
 
-out_pin:
-	xdp_umem_unpin_pages(umem);
 out_pgs:
 	kvfree(umem->pgs);
 	umem->pgs = NULL;
-- 
2.43.0

