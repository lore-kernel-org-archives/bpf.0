Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671E498918
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946505; cv=none; b=E8OaZhEqPfAsC2scG/gF0DpgotGgCrS9WkMEJSoKcxP3gT7P9Vnz8BYgm5Rzq0nUmIzIXhlY3dTecSeyYNotiWCid7gRYmvYj6FYr7m+qNGUkLAMQE5N9yFu9EQqb7DO1pVvfLJVnOFk3fGD/x2niEy3wSvdAzKi1Zwwcm1NYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946505; c=relaxed/simple;
	bh=5wSAEahH9cAQEKwatoSdFKO0aE9BxweuQlJhzvnO/Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIlnpoymGEKSQIs/qe9P2SJYnwLJTri32CSnO0iTyf+SaKwdnvWNxot+wEIDJXDZ+cYeUuTsEnhrYKVukEhsBAfqPojSsPA21QdBy3gi7SUWh+tZOdFCEN7I2GkVKdRMdresItijMavkNlsdPTEmbTsgeAiyOFfAm8QCW+gE6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vmpe9hWR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vmpe9hWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790946494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUHnkDSrrfCXFMH8IJydTfHAXtd3mYVbUu8G9r9OmXs=;
	b=Vmpe9hWRx73GmDQlvFZrniapy1j8egX8ThZG0SCrzxgZLPCWkJq4bZn+PpsEXjMsfx8KhT
	Z03wFlfoYDbITI6cjumNkZA65gWEYTC8/WV27EmBsrg+TanqXf9kdifSMGJzICbpnyR/bP
	NKl1eMGvrG73Qvw4CXkm3rVFH011pr8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-VTi12gDzPNeEvE01KJKvzg-1; Fri,
 02 Oct 2026 09:08:08 -0400
X-MC-Unique: VTi12gDzPNeEvE01KJKvzg-1
X-Mimecast-MFC-AGG-ID: VTi12gDzPNeEvE01KJKvzg_1790946484
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E20A118F4BE8;
	Fri,  2 Oct 2026 13:08:03 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA859433;
	Fri,  2 Oct 2026 13:07:55 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Henry Tieman <henry.w.tieman@intel.com>,
	Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Preethi Banala <preethi.banala@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net 00/10] ice: port missing i40e fixes
Date: Fri,  2 Oct 2026 15:07:42 +0200
Message-ID: <20261002130752.2597259-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This series fixes bugs in ice that have been fixed in i40e, some of them
years ago, but are still present in ice. They were found by going
through the i40e history and checking each fix against the current ice
code.

Patches 3, 6 and 8 have no i40e counterpart. They showed up while
verifying the ports and are kept in the series. Patch 3 was found while
testing patch 2. With the IRQ unwind fixed the netdev still could not be
opened again after the failed ndo_open, so patch 2 alone does not make
that error path recoverable. Patch 6 was found while building a
reproducer for the i40e MAC filter overflow fixes. Those are not part of
this series, because a full switch table on E810 leaves no room for the
promiscuous rule either. Patch 8 was found while checking the i40e PF
reset fixes. It is an ice regression of the poll loop timeout check,
which i40e does correctly.

Every patch was checked on E810 before and after the change. Patches 1,
4, 5 and 6 have plain reproducers, which show UDP tunnel offload lost
after CORER, an always empty default XPS map, VF tx_dropped stuck at
zero and multicast filters silently not programmed. Patches 2, 3, 8, 9
and 10 need conditions the test box does not hit on its own (a failing
request_irq, a hung PFR, a WoL capable port, counters past 2^32) and
were verified with fault injection. Patch 7 was verified by filling the
switch table, with debug prints for the failure analysis.

An LLM was used to go through the i40e history, to write the
reproducers and fault injection hooks and to draft the patches and
changelogs. All of it was reviewed, and every fix was tested on E810 as
described above.

Petr Oros (10):
  ice: replay UDP tunnel ports after a core or global reset
  ice: fix IRQ freeing in ice_vsi_req_irq_msix() error path
  ice: stop the LAN Tx queues when ice_vsi_open() fails
  ice: restore the default XPS map after a netdev TC change
  ice: report VF tx_dropped with tx_errors instead of tx_discards
  ice: keep adding MAC filters after one that already exists
  ice: take the switch rule AQ error from the response descriptor
  ice: detect a PF reset that does not complete
  ice: program multicast magic wake before tearing down the main VSI
  ice: fix unsigned stat widths

 drivers/net/ethernet/intel/ice/ice.h        |  8 ++---
 drivers/net/ethernet/intel/ice/ice_common.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c    |  6 ++++
 drivers/net/ethernet/intel/ice/ice_main.c   | 36 ++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_sriov.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_switch.c | 17 +++++++---
 6 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.55.0

