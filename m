Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658868;
	b=0Frri2/P4CXM6+7lHG2n7znUNK56VQ/1SOqz7NyEVrZR105ye/yQe9UeQHFjPCctAZYS
	 hgP/tfymtebgg8k1VvBqwShHwek5ow6KR8AaFU1UMXpO6rhDTE3JMxwM62LonaD5T1jTF
	 uyuO/K/LDdKKKc0oyh88GBr4t+ZbB7BFWmU8CcoO0c8ri99YheT6cxsk0TCNaioFjrfoj
	 tjN3Y1mdV4ouXVIonzR5SeraVmu2aYE+bVsgPDei2rVKmfxyi3X5n3nLWC+iCoghfzYXL
	 sMZQZzvQHEbi+UmLVt9w3dh92h0QeRv8OwA+2RGf1enk+VPkv2YoiFuod4b0FzIWC9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WkAms7KA42Baas5n6wZEyMjVEZ8N2pj3aqq6PvvQjdE=;
	b=kkjDyLXsdwiV0j1TVODrVKPpRg54ebft/+PgGQMiZWvG5i0i+xOjoqoNJvicO5F4u8BN
	 /par/7E8DHBOy5+jsH8frPzuSiv0yqTI+Efdk3Yhjh0+8faIt21Wyg3qnlkEEF0h51J6f
	 PhWqpM0Gfh4bZDCUxsJCvZxJXKJVAtOb4824GMDJ/eu5KWs6MA+sHemw9wjwP9roFXyje
	 GffDw6NT93ZSuBuP7r5CIo2HZ2Z8aAwVMPNSxoI3CZiIqLBN9jN6WhbgUCAgVTWE+F6Jk
	 CDhHoHEtQpXRNd93fOgPf+NDhUp3rGmhP82s46BFD6abQpoOmVx4rUmavKgxZxD/OHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=povKuKh2;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C9606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 02:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2C9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=povKuKh2
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f0464dd6b6so40285405ad.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 18:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795658867; x=1796263667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkAms7KA42Baas5n6wZEyMjVEZ8N2pj3aqq6PvvQjdE=;
        b=povKuKh2H6D2wLFvEqnB2T8NXUi566C8IhNc2LNF7XF5xNAcQPsYSsSfd0VkOp7Jxs
         WROFL3uX6OL9vmEUoSUtnvvhcQDFI4rQqOAnY0/ecwRlpYKolkNepVHQuINeEoi9jUHJ
         a6X64fiydSLPsroytYNKtNYqrQZ5fa6vCUDHo6M3UiRC3lCWWPfZlMXgnQ+UJmIJHE20
         DaZPYoZvUQZSKaaguAWJwabMv5QSumxhDxkkK7aYxS7nO6K9RXKulGx6a03mb4lfzHMQ
         RFmV5ddqWtI0V/zGXPwRxcLpILZHiimz0E1WBC5f8IbWWJXiVn+MG4rkAUc0jWr3qrHw
         tQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795658867; x=1796263667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkAms7KA42Baas5n6wZEyMjVEZ8N2pj3aqq6PvvQjdE=;
        b=n9ORMfPvZp9PsQi+etzio7SwGWiiY2gj08H7JvcyxCLngAXfmYyuZo9uKMQKtSFgXX
         9rp37hINH7Bb/oTHhjqh7Y4NsbmeoeXqUZhtXGgEWQ167ndCffrHZtAZv7pAojnmz3Z/
         NtWxUpMn+3lJU8rWAIixV2dwflVj9I1SEENrUk2/Hg6JgPIkin7cuCUV478mUnAwrg4Y
         CtXO+pNbicfE+ez4ObXAXCrPvIz2ioZflI8PJUICez/bIBszyx+BdcCDBvIJQnaGUKqF
         VUjq7ShYgKRahTTatS6iU9qm0eBA4nCzhn7uzLbc78bZsCgK9EgfK/uG5MdKbxsbkoYm
         jLOA==
X-Forwarded-Encrypted: i=1; AL+hErFtnussWMKrjvKBiloYYfjzzOu59j6z5Bz9yKlGyvrN43g1WTQT13haW29DcHspuQoRK3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4lJusTuiQ0IhWBDJujJjf9jDUWJBmaAET0TquMMPfwUK5i4SU
	+6UKy2RWhVrnBFApEnuCEUwDC/gSeJS8QlAQwBU3WCkn7sufgncTjDkh
X-Gm-Gg: AZFdTZdP25DE+fPyj6PM1QxbN+6+HqtMFAGJ+oP3x2rsjR68cAoVgmZAR8W8Ls9d46D
	5sx+2m1lTpxZoDVhT7QGGgv9GYfa1G7zHzawZaXpb1X+CQRpbyt32d2DTizpYxrx2wsXIdAQU9o
	Zj18QT4EoQHYA4QWB4pFyOrUkxHhgxXjr46Ng1gbAO/TdtMg4Ra70/3/4UX2V0odL9EdyQFdoE/
	9iED2NtfwpIR8UuIHJ0gE/+VU50d46sNU4o5l89DV1SLsBn7sJIkPk3hUXulvwkuCeT1XLKvBTD
	mJxWNL69QzhQteV12FRWG3eLO3m6P1oToh5OPjeAIDotospCFSB4rpk9bYsG+CtCh7n6gyNEoWW
	7hU9uFvoN2atqfpcnzFJ67iKIh+NWB/oyEPxRBq2vajnNRu60FmIOeO3Iub0jI6TMHuwH2nNAMR
	jjDvf+mtAigHvbsinzjqpUvovjUKEJ/AYFcWO9zgR++UPkJTJtZGpzjPXfX5nxugHh3gicLMW7+
	RNG10sxcpf4wYNpEJYZXZEOROKzB3PGX4v7Id/YttSjiNTAKKO44W1CdjkN0IiIUd7T/CgpJ7eu
	eUC72z24ixvHKfqgGIS3y8xG0I9AZojVHtr/PnOarReO/+0fz2UCWbkGb4MU+PQLuCw6Zs9WUB5
	dz2SGBfxxSnHd
X-Received: by 2002:a17:903:2f87:b0:2ef:e285:7085 with SMTP id d9443c01a7336-2f03f1b1946mr192913505ad.44.1795658867206;
        Wed, 25 Nov 2026 18:07:47 -0800 (PST)
Received: from d20be28ee783.tail196be.ts.net (vldb.skku.ac.kr. [115.145.173.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c6e50sm95550735ad.13.2026.11.25.18.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:07:46 -0800 (PST)
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
Subject: [PATCH net v3] xsk: keep the charged page count when pinning a umem fails
Date: Thu, 26 Nov 2026 11:07:42 +0900
Message-ID: <179562059260.3381969.13546710565371160648@gmail.com>
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
v3: simpler error path without @err, as Maciej suggested; Bjorn's
    Reviewed-by is not carried over, as the code changed
v2: https://lore.kernel.org/all/179556786851.2007362.7849536379916971930@gmail.com/
    target net instead of bpf (Alexei)
v1: https://lore.kernel.org/all/179552079829.1290967.12345053263834529704@gmail.com/

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

 net/xdp/xdp_umem.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index cd8643360eb3..ad72bd96905c 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -95,7 +95,6 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
 {
 	unsigned int gup_flags = FOLL_WRITE;
 	long npgs;
-	int err;
 
 	umem->pgs = kvzalloc_objs(*umem->pgs, umem->npgs,
 				  GFP_KERNEL | __GFP_NOWARN);
@@ -107,23 +106,16 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
 			      gup_flags | FOLL_LONGTERM, &umem->pgs[0]);
 	mmap_read_unlock(current->mm);
 
-	if (npgs != umem->npgs) {
-		if (npgs >= 0) {
-			umem->npgs = npgs;
-			err = -ENOMEM;
-			goto out_pin;
-		}
-		err = npgs;
-		goto out_pgs;
-	}
-	return 0;
+	if (npgs == umem->npgs)
+		return 0;
+
+	if (npgs > 0)
+		unpin_user_pages(umem->pgs, npgs);
 
-out_pin:
-	xdp_umem_unpin_pages(umem);
-out_pgs:
 	kvfree(umem->pgs);
 	umem->pgs = NULL;
-	return err;
+
+	return npgs < 0 ? npgs : -ENOMEM;
 }
 
 static int xdp_umem_account_pages(struct xdp_umem *umem)
-- 
2.43.0

