Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC913AFB1C
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500481; cv=pass; b=F4Zk2hSWazvuEClgMsb8uJtY0PugI8WRHcXvm5d7V9tqoQ4bnPSPPSjG8/FMlS+gnKDz0+LoLcjwuQ0yzXhP0C2vMLKLQuI9f8gWvtas4xCBmA9W8Q2oE0u1Dk/ntYsvNknkIaur9EgtiAmwPQLS55X1P4bJcHs8/Sf/IT8vJmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500481; c=relaxed/simple;
	bh=aEP7uy33qGNpUUDQxlNY8I1X9OL2s9AG5vb3XEuG76o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOB2oBZSE7GYURmuaPVwUCKuZCs0tfRLyItNHPYqwGCkMfTq0A2BNMaH7rQDaFKDCof+qsadL2gS4vRN8fCYKeMAwPMwso5CjBaEO88ThaxamDuEerGdOffIiYn0QjhNLTGvouizU7CvLiAAqtQAYNi3ST63s005cXlKbUaSDuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CSevkJzd; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CSevkJzd"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-857ff9fef54so6619857b3.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 22:41:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788500479; cv=none;
        d=google.com; s=arc-20260327;
        b=UREL0WqHp87TWULzaeFOjDQ83x0K16ReUBottZMRDk1DWcEc5qDo9l9rG+Q26YSpvk
         zDPgxib1DL+iUCCGVz4KG2AY+Fa3JLVOdD+882Mc2+xKxgiEmEcOnYcqcYL6FkpiWKoH
         grEQzyTfGUXjvYcxrznZa21SgKmP6x1n66+CPFgiO1pjgKVZq55XBhtEOhiEoS5fjN6U
         0sTtCUUQeP0LtKET/2I3CIRxsehwynV2KDtcPrXvDi3B1LQvHTfNkaIXvyZ3putB5rHQ
         ckGhU9zK6EwCXFf750QhXzJ9e8LVS7bagw9VIinTRy+6WkbTXQ0DYtQXf4OdHCt63/p2
         Er3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EuqE3ueVRiiHxh+pCSOdLubfFSA664DpxbaoLMe0ato=;
        fh=5Q78AWiAcvfF872c7Qh0SYBgI1D97IJddwoA/fJNuwU=;
        b=ZjhaQdg/pitZ5bX7VVLNIir0prscOAws2oBX8uRqqWeKZDQ6qX/kVmkvUOfQ1GesDp
         cjwMgPumIzhcrli044oqnIs4lJ1WoNUUyt0Zx2+CYTku/p4jRgsVg2LzriSVxvpAnY4i
         9VFVrXuQrnPyrpwX9veqmhrUoAN62a3Tv0i8HNnvaCrgCUPqfG3m+FuwCTRf+l2qRslp
         ojwtCKBJUoDoejvYJkMFadlS5ZRUpzFaMfIV98tbtyE/HN3jgGZqdgU6Ohoyn4Ow5gZh
         q7HtWpuq7CwPhcuDtNBqRPwfLGoPluK1HgtF1IRxxSLoD10DB1c/UuWq2UegQlg3c64G
         EwJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788500479; x=1789105279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EuqE3ueVRiiHxh+pCSOdLubfFSA664DpxbaoLMe0ato=;
        b=CSevkJzdj/mbLj+qNLY8wxuZo8cDYLYmf/y5vaicKUV71Qx+NwtLWlhFxY5N7hiRmR
         qMjE31yjhZdFZxXlML/PeDFDdG6sR41Qbp7uwtnT7WaDbOC/5oycXRvUrpjAyQ/aGACf
         /RnECDpMeB6zj4jdLVUtsyKDN/NKMBI5Xa5rVldDPdk7Gwq7KDMbLLyLCNWm4kfA4IIX
         V/WsHNqP+uMw/HvodTfIKs1THYs1FT4VG8pnX2SnHlZMeW2I57N3ocmmDxIV25HBNqTA
         LJyXvWqS162HkzX8wWQlTstnWvKSGHwvjvs7ERQMgnR/DwHlv3t9BMykKbIaPBGbTjLT
         rN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788500479; x=1789105279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuqE3ueVRiiHxh+pCSOdLubfFSA664DpxbaoLMe0ato=;
        b=ZagLVDYtTPaxflC9OKP8ESDsYBusfzqE6F6uGVxRsMYLw4Iepcfn+drXBLk+Nz5VRC
         IJUIrAEmmb1O2+M2tkEoWhDvL/W48+wwOxLQPb77zxOO5IcDusEZxKOuon5UF+pkyfId
         ibbLqK7BwEqomNqkEOxh9K3dISDYevzDhleNUOG34LcWxBsC8U978VfuC15xzZtObCV2
         DVDZ/gLiJa6XCsahP5Jv1XeyFFXtYjBUC5b9FOj+ixm/1paVxQjUr56R+ByM26rVtxOd
         nPNvn+0dP4WNBx0QZX2X9GTQtoG+dAaj05bNlC157MrtKXt1ldktTFhGbV0VPES/4JWL
         MjFw==
X-Forwarded-Encrypted: i=1; AKwUvBxlHJav/H5ldgydrz+8pHK4LHWCVgZRiACTG9Y4i07BmwgUSMvxP9FCQfmRRHPtQlbK4Xc=@vger.kernel.org
X-Gm-Message-State: AFuF++lvB2EKJ7FAkmLH6Ngh+HHmnioTNRUWcQV5S2kbN2l73DXRSDyH
	vpzYEPOWtHcRVGGFRJTmnqf9xF08Qim5s7hYmcfJ4+dLmFYL33EKNJ3Tbx7V7VqiK5EGQoCLN7B
	L7y6GmaSe2TFu4fmo+C2MG5wtfikVfjbMzghSRixcOQ==
X-Gm-Gg: AYBFou2N1WVb2Biv/M4Oyj+caK1eU9XAyYvmP5DWyxnL6NfZ0I6vTwyNq0RNg+fVVtd
	vEbRs9cz8g2JuQoEdH2T3gooZMv7fJk6Wz4AU8aO4is8GtJI1HePoouYTKFs4TrVx58V+TzTNWF
	rVUWf/Q3+WQ6f/4GETfAdISwstrLh573QfleKXOuYTul3QeA48dKdV6HXu+FOJQkcaxxwicNvpl
	rDHqLmIO1rAHBDG1RlMwP7D6y2VlPDln1cbApkKPm4EcEfq2zizALs3EqvP/swuFCgXHqv2NPk6
	z1baFtJWZ153pCkSBQMefOBbEokDecWxp5jN2TY/kZ0k
X-Received: by 2002:a05:690c:a7cb:b0:81e:6658:53fe with SMTP id
 00721157ae682-87126aa6a93mr15719417b3.20.1788500478753; Thu, 03 Sep 2026
 22:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
In-Reply-To: <20260819024443.781764-1-tushar.vyavahare@intel.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Fri, 4 Sep 2026 01:41:07 -0400
X-Gm-Features: AcwNN1W0qi_ei7Umz4XIh7S5aRdHKz5JTDd5nP5DkVfbP_TCgZcBavx87UB0Ftc
Message-ID: <CABFh=a4ooWHaSzd1sk7bEP=KT1e+24EjJ0344aFg552ySoj_7A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM coverage
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, stfomichev@gmail.com, kernelxing@tencent.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, tirthendu.sarkar@intel.com, andrii@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 10:53=E2=80=AFPM Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> AF_XDP shared-UMEM support in the existing XSK selftests is limited to
> a small set of scenarios, while the supporting setup and cleanup paths
> become fragile as coverage expands.
>
> This series improves shared-UMEM testing and infrastructure in four
> steps.
>
> Patch 1 makes UMEM ownership explicit with refcounting and centralizes
> socket and UMEM teardown, keeping cleanup behavior consistent across
> normal completion and error paths. A UMEM that survives teardown now
> fails the test instead of leaking silently.
>
> Patch 2 prevents TX setup when RX socket configuration has already
> failed. This avoids shared-UMEM TX setup relying on incomplete RX-side
> socket and UMEM state.
>
> Patch 3 expands XSKMAP and test capacity to four sockets and adds a
> length-based XDP steering program. The classifier uses total
> XDP-visible packet length (data_end - data) and SHARED_UMEM_LEN_SPLIT.
>
> Patch 4 adds the shared-UMEM callback runner and initial 4-socket,
> length-based steering, uneven-distribution, and unaligned-chunk test
> cases. The three packet-stream sequences share one transactional helper
> that stages replacement streams and publishes them into the socket
> arrays only after every allocation has succeeded.
>
> Together, these patches strengthen shared-UMEM setup and cleanup and
> extend selftest coverage to multi-socket and packet-distribution
> scenarios.
>
> v1 -> v2:
> - [1/4] Track per-slot UMEM ownership and centralize refcount-based
>   teardown. [sashiko]
> - [2/4] Publish RX failure before the setup barrier and skip TX setup
>   after a failed RX configuration. [BPF AI]
> - [3/4] Trim the length-classifier comment to match nearby BPF style.
>   [BPF AI]
> - [4/4] Clarify the partial stream replacement leak in the commit
>   message. [BPF AI]
>
> v2 -> v3:
> - [1/4] Keep one xsk_umem_info for shared-UMEM TX setup instead of
>   copying it; initialize only the non-owning TX buffer view. [sashiko]
> - [1/4] Propagate xsk_umem__delete() errors so the stack-allocated
>   zero-copy probe cannot lose deferred cleanup. [sashiko]
> - [1/4] Record UMEM deletion failures in test->fail; in-test teardown
>   cannot retry them. [sashiko]
> - [1/4] Collapse the redundant teardown helpers into a single loop.
>   [sashiko]
> - [4/4] Fold the previous 5/5 rollback-safe stream replacement into
>   this patch. [BPF AI]
> - [4/4] Factor the three stream sequences into pkt_stream_replace_seq(),
>   driven by a pkt_stream_dims_fn callback. [BPF AI]
> - [4/4] Drop the stream-readiness check and the uneven-distribution
>   hook; neither could fail. [sashiko]
> - [4/4] Drop the unreachable NULL-safe UMEM guards from the unaligned
>   test. [co-pilot]
>
> Co-developed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
>
> Tushar Vyavahare (4):
>   selftests/xsk: add UMEM users refcount and centralize socket teardown
>   selftests/xsk: skip TX setup after RX configuration failure
>   selftests/xsk: expand XSKMAP capacity and add length-based XDP program
>   selftests/xsk: add shared-UMEM callback framework and initial test
>     cases
>

For the series:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>  .../selftests/bpf/prog_tests/test_xsk.c       | 340 +++++++++++++++---
>  .../selftests/bpf/prog_tests/test_xsk.h       |  27 +-
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  15 +-
>  tools/testing/selftests/bpf/xsk_xdp_common.h  |   3 +-
>  tools/testing/selftests/bpf/xskxceiver.c      |  40 +--
>  5 files changed, 344 insertions(+), 81 deletions(-)
>
> --
> 2.43.0
>
>
