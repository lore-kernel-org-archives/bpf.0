Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468419;
	b=Ly6RQD2WIf7emxvCCUjc2MUJT3Wefcv4sdLgmBKXoSVVw1922U+KYlXg+pjOl7YB+6K/
	 3tce1s6EkJ6Y+IenjXrBcNUIMhQxU+GfQFvVxkbg4twoVTIv6EPjugeS2QKWpry6xkdsH
	 k+oROG8yFTtGuU3fo2s2QNcgwTAHGLArYmmabrAMdyJ/m3wqSjZdtJKP/rrn2RSJFI40I
	 J81bA9yyGpFIrDjGn4ZGAoD620Wq9vTHI2+4wH/SOae4UesHES97E86QVp+6Jl5xTxjUZ
	 H/4nbuefZJZxrzzqZT7gzVc5Qx6iFRUg+edwRCUTBL+MtstRbP+XxPMgKX5uvO6wU+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=e9OajFTsYxwI4ZTtVmhzq4Ffv1n1BXjie90/C+g5pMk=;
	b=5fqwYDbL6QGxd5AaFXtRpUid3NAv6VuJgBH3Cxtve0Wi3cfAKPNMz4FqYyUKuvco4GVW
	 y0wXjkQvY+OuRYfu65ugvl9qVy7YB1dFKWqVx50RY1qImA+bp70OmYJpI+8TMeSdYSTvV
	 sLbcRs09vq36exvbnvC1WsK3j2p0JWNpboDFVUYksqhFywqSt6SClk6r6lCGAZsGD4Qw8
	 3DKZg5PDoJfrDXnkBNqLaFY1275ymVDx4QND+y0G0+9xKQYb2UXB1WVBwyUc4PL8UVPqW
	 BSuTpmFh7H2wpwKuWjSUNj5nGctcB8TF0YkEZvAy4+zrz6WkPMnw0lQkK8A1oyjotZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pehIvgR8;
	arc=none smtp.remote-ip=74.125.231.134
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8A606A327
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE8A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pehIvgR8
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-862990b7bbbso1260428a34.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468418; x=1796073218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9OajFTsYxwI4ZTtVmhzq4Ffv1n1BXjie90/C+g5pMk=;
        b=pehIvgR80jttZTN0k+2MQhyKc0Nf5gKzkjVdb7dvVNCH5uwfWBwmZ3mVJL2fYk6Y58
         GuoXxlifLZ5OdAV582kHP95pR1J7L8WsCRn8d7L7lsVLwFyeZ9pZHeKOo8s/As66ltBa
         AkM68OYOQTOm12VVvm76FTY5AiYgLXmG5EyyGHIl3ZuxTn7JNsQe7ZsYwWkqXXVqfq4q
         gvuVkgy98P0fX+dONcAAGDso4VUINJu0Tmbgduw0+xJaNr4Phlwj1/5gD5CBIXtqqHMq
         n0RCaODYPdVuLMAb3v0HFXDPv+8+fVRCYseE6BzFNk6TY8ZHAbVdk6r3JNICzTzWkx9x
         kErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468418; x=1796073218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9OajFTsYxwI4ZTtVmhzq4Ffv1n1BXjie90/C+g5pMk=;
        b=H/9Q9Kb6hOEAr7RXb3Z2XDZkXQVv6waollBoXIMdO95mVG6niI+MBmhpVHmnhxIaVp
         +bL1ikCvxwX5hfruDRn5FKSu3hB30M6CGZlFxFQtMd76iiEtOOHMMkRHJ4c7fODZA95T
         B3eGQrpmxxiNOfnvMwZa6YZm7D8IediCcLAZ1e0GhiRBILRj5Qm1kEzwlFuhBxO/hx3u
         aMBm4d8g1SSiZt0f6VuDjHTduBOloZyJnbOtjs/fYTftciqo0yCsyB6Xp5ji2x9Y+MBV
         XeqWYRuGFhnBTlgGVtW9QyZOHxyavjMX6uI5CsNWTsATCPmux9Q4m/6BkoX9V5F1KLIW
         rHYg==
X-Gm-Message-State: APuU4Z8a/FtnhuRi1AtL67E8WUGoDhSIQiiL4kG9D51CUIPqc718qTNY
	DntU4XYn4fqSGyTjT9jvizGA34pclXDI+0g02MfVvP4CC3QGghYruNvA9hqAgX//jKHpEg==
X-Gm-Gg: AZFdTZfrOhjByIoERosv9V/9itkGdASD0s7FrBRSYofuWXP5SoCHyqpdZqw6+szBo1c
	vNsiFe3VrqMrRjdwwULwns3WUK9Za6Vxga8ay4fv4+MWT83Qo8FEFRm2OcaXO8yJlYarRI9Rvwu
	cvsTxq9vhlT+uaTcF5yY/fU3FwTRDI6nfjXm2iwdyLQ5puiDovWPN0AfLu2CGBDHyM6kPLr7MQu
	QvRRq3SIBshSir8C3WwzmJ9GzZMYPB+CQXaUqSkKPWfiTtnc060DN0mw3PcGg0J+KVoiWjcQ20n
	szeZfWjwVcxVxSDl7DTd0BY27rNJp8WDOkrSfpHiSfI4LIEf9vm6AOKZKZUCVbeCDxZ4aK+Wvqx
	SGV1iYhmrpsftQo/ShS9gzNYKNbstfABK2uutDLXU+UHfXR0+aUHM5BaMzSshoIvwNA4S0DK2eO
	9Tkghfrf9JtK+DF5tq/8Js0qTfmZ2paTH7xikCgQgVjh9T9Lxdk3nS5/E6BWmr0Mz637cMhdsdn
	kLkkpHVlsUy5mmP58+Qo/NeeKnmlsgTumJg4cabl8lXeMEsDoMmvlFSt1n66hc9cMVF6jOOPc/I
	HhPbsKvjYXz4kfGF97RsNgxhaiuAqOZdkEPwELA/GZsToA+qdjhS/ihd03rtgBMXeNJT2pNmqIC
	/cQDLU7mbajC3RqmEXCINQdY68eLCQmdf+SRriNsc3iQtAGz7zMbgLFFIkiiV+BLa6tsKQxPqPf
	GEpreas5vR
X-Received: by 2002:a05:6820:c2d3:10b0:71a:f637:e5ea with SMTP id 006d021491bc7-71b39527e73mr7037758eaf.22.1795468417619;
        Mon, 23 Nov 2026 13:13:37 -0800 (PST)
Received: from localhost (fwdproxy-atn-030.fbsv.net. [173.252.95.30])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d9asm9884036a34.17.2026.11.23.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:13:37 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/10] Ring Buffer Iterator API
Date: Mon, 23 Nov 2026 22:13:23 +0100
Message-ID: <cover.1795467315.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5182; h=from:subject:message-id; bh=6gOdZEdAICRB8GwwVrVHhzIYzbKuw1ohoNljTsVp93Y=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlhbESQ024B2O+/d8Xnf42B87I9Z0RrckLeuAW3dnhfOT1 tjcdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMhsH4b/VZeWT8iJWam9RVj4X0hU87 30Ca/ulii6Ln598PyEJP+QBIZ/KnE7nJ1eeHYGpdb0rPqd+WXBTdnzwvLpd6ZH5F9wWbWdDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

libbpf can only consume a BPF ring buffer through a sample callback, e.g.
from ring_buffer__poll() or ring__consume(). This series adds an API that
returns records to the caller one by one instead.

It is needed for overwritable ring buffers (BPF_F_RB_OVERWRITE). There, the
kernel doesn't wait for the consumer and overwrites the oldest records when
the ring buffer is full, so a record can change while it is being read.

libbpf rejects callbacks for such ring buffers since commit f756eedb24d4
("libbpf: Reject overwrite callback use"). v1 of the overwrite mode series
copied the readable data before calling the callbacks [1], and Andrii
asked for an iterator-style API instead [2].

The API works for regular ring buffers too, e.g. to process a number of
records before consuming them, or to consume a ring buffer from the
application's own event loop without a ring_buffer manager.

API
===

  struct ring_rec {
	const void *data;
	unsigned long pos;
	__u32 len;
  };

  const struct ring_rec *ring__next(struct ring *r);
  int ring__release(struct ring *r);
  void ring__rewind(struct ring *r);
  bool ring__invalidated(const struct ring *r);

  struct ring *ring__new(int map_fd, const struct ring_opts *opts);
  void ring__free(struct ring *r);

  int ring_buffer__wait(struct ring_buffer *rb, int timeout_ms);

ring__next() returns the next record without consuming it, or NULL if
there is nothing to consume. ring__release() consumes all records returned
since the last release or rewind. If it returns 1, the caller has to call
ring__next() again instead of waiting. ring__rewind() goes back to the
first record that was not released, so that ring__next() returns the same
records again.

ring__invalidated() is for overwritable ring buffers. It returns true if
any of the records returned since the last release or rewind may have been
overwritten. The caller has to copy record data first, and use the copy
only if ring__invalidated() returns false afterwards.

ring__new() and ring__free() create and free a ring without a ring_buffer
manager. ring_buffer__wait() waits for data in the rings of a manager
without consuming it, for rings with and without callbacks.

ring__next(), ring__release(), ring__rewind() and ring__invalidated() can
only be used on a ring without a sample callback.

Usage
=====

Wait with the ring_buffer manager:

	rb = ring_buffer__new(map_fd, NULL, NULL, NULL);
	r = ring_buffer__ring(rb, 0);

	while (ring_buffer__wait(rb, -1) >= 0) {
		do {
			while ((rec = ring__next(r)))
				handle(rec->data, rec->len);
		} while (ring__release(r) > 0);
	}

Wait in the application's event loop:

	r = ring__new(map_fd, NULL);
	epoll_ctl(epfd, EPOLL_CTL_ADD, ring__map_fd(r), &ev);
	for (;;) {
		epoll_wait(epfd, &ev, 1, -1);
		do {
			while ((rec = ring__next(r)))
				handle(rec->data, rec->len);
		} while (ring__release(r) > 0);
	}

Consume an overwritable ring buffer:

	do {
		while ((rec = ring__next(r))) {
			memcpy(copy, rec->data, rec->len);
			if (ring__invalidated(r))
				break;
			handle(copy, rec->len);
		}
	} while (ring__release(r) > 0);

Dump an overwritable ring buffer without consuming it:

	n = 0;
	while ((rec = ring__next(r))) {
		memcpy(copies[n], rec->data, rec->len);
		lens[n++] = rec->len;
	}
	if (!ring__invalidated(r))
		dump(copies, lens, n);
	ring__rewind(r);

Patches
=======

Patches 1-2 are two kernel fixes for overwrite mode; they don't depend on
the rest of the series. Patch 3 documents overwrite mode. Patches 4-9 are
the libbpf changes and patch 10 adds the selftests.

  [1] https://lore.kernel.org/bpf/20250804022101.2171981-3-xukuohai@huaweicloud.com/
  [2] https://lore.kernel.org/bpf/CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com/

Kumar Kartikeya Dwivedi (10):
  bpf: Order record data after the producer position in overwrite mode
  bpf: Keep an overwritable ring buffer readable while it is overwritten
  bpf, docs: Document the overwrite mode of BPF ring buffer
  libbpf: Account for the overwrite position in ring__avail_data_size()
  libbpf: Add a record API for consuming BPF ring buffers
  libbpf: Add ring_buffer__wait()
  libbpf: Support overwritable ring buffers in the record API
  libbpf: Split ring setup out of ring_buffer__add()
  libbpf: Add ring__new() and ring__free()
  selftests/bpf: Add tests for the ring buffer record API

 Documentation/bpf/ringbuf.rst                 |  44 +-
 kernel/bpf/ringbuf.c                          |  24 +-
 tools/lib/bpf/libbpf.h                        | 139 ++++-
 tools/lib/bpf/libbpf.map                      |   7 +
 tools/lib/bpf/ringbuf.c                       | 336 ++++++++--
 .../selftests/bpf/prog_tests/ringbuf_iter.c   | 586 ++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_iter.c   |  66 ++
 7 files changed, 1155 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ringbuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_iter.c


base-commit: 2bf3351c5f894697e8443eeef5333d4c4ce90cab
-- 
2.53.1-Meta

