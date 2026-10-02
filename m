Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63F484893;
	Fri,  2 Oct 2026 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935600; cv=none; b=jMS5fvM6N3e4cBI/0s07B7qncYIbzvIStRTkSEAmMg3nVUa8cD31fdiR+Fo1AWeuDooSx19LBuT6XLWksGYsFvMbaa4XFTdE/N2/1bK5+Axm7sLngHj74FeHJTMEBba4348ssRDoAsNhN/JzBfKr9BegeAmBii1MkCv9Bs2oJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935600; c=relaxed/simple;
	bh=IqKWJjRt41C6O4MUNqYIYHrCwGfZbMGaflN8qh0sfhM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RD2QV781OF0dajbyflrWs9ru5HHt/W8HnqP1tukkd1TVI88Ael+1Yajoqzn9GJ/4cXshiugSiEVkQnjlKAEbJJGRwR47F+8hVAd9qPMJCPiiHxF8JfYUK6u4SQzSUpgev5cL3Xz2LqnSnEN3765/qQ4G4nngUAcnN9Ywyoep01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgI6CGJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgI6CGJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3491F00898;
	Fri,  2 Oct 2026 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790935599;
	bh=Ic1SjBGv/4rIMwRL4Rwub+p85yR5F1uOzz4qMF9aNAc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QgI6CGJPrnt/iJhWpQwBSIySRVi2loL2YtJpgx8+HWhN2uMAI/SR691xhMWVVtt46
	 JSb54BlOqWLcJ+JAC5H7ptLO0rkfql46Qw6W0MNNmSvcHeYh7VZP71SbKpBrGUxMaW
	 OU2JViVNRYBlWQzS7wl3CVlM6C4EIe164WBjySvEyisfwCoJRK0EbGJHapOH6AO9wY
	 tNAPZyqofr/l8tB96jUktL+9o+4pTqLA0HClEBZxCWaRtXn0daKXW/gNzAJNNp6dJ8
	 W2QAz2CW+16v2cDbGniOTSfksHSVsYbrg2Pw7uqJBp4JgWn/DdobjKwVRapUHUZRuh
	 87yhaq9BX5jLQ==
Subject: Re: [PATCH net-next v9 09/12] gve: introduce new methods to handle
 IRQ doorbells
From: netdev-bot+sashiko@kernel.org
To: hramamurthy@google.com
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com,
 jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 przemyslaw.kitszel@intel.com
Date: Fri, 02 Oct 2026 10:06:37 +0000
Message-ID: <179093559726.434549.2118678373272356755@kernel.org>
In-Reply-To: <20260930190428.1130007-10-hramamurthy@google.com>
References: <20260930190428.1130007-10-hramamurthy@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message of "gve: introduce new methods to handle IRQ
  doorbells" claims more than the code does and leaves out several…

--

gve: introduce new methods to handle IRQ doorbells

This commit adds request_db_info and release_db_resources callbacks to
struct gve_ctrl_ops. The AdminQ implementations issue the configure and
deconfigure device resources commands and set the per-block irq_db_index
pointers. Allocation of the irq_db_indices DMA buffer moves out of
gve_alloc_notify_blocks() into new helpers called from
gve_alloc_control_plane_resources().

> Admin Queue and Mailbox modes. All behaviors related to the IRQ doorbell
> indices will be managed by these new methods instead of occurring
> directly in notify_block setup/teardown methods.

[Severity: Low]

Is this description accurate for what the patch does?

gve_adminq_request_db_info() only sends the configure device resources
command, using the counter_array_bus and irq_db_indices_bus that are
already allocated. It then sets ntfy_blocks[i].irq_db_index.
gve_adminq_release_db_resources() only sends the deconfigure command.

The DMA buffer that holds the doorbell indices is allocated and freed by
two new static helpers in gve_main.c: gve_alloc_irq_db_indices() and
gve_free_irq_db_indices(). They are called from
gve_alloc_control_plane_resources() and gve_free_control_plane_resources(),
not from the new ops.

The next sentence says GQ ring counters will be managed in
request_db_info. However, the counter array is still allocated by
gve_alloc_counter_array() in gve_alloc_control_plane_resources().

The v3 changelog says this split was intentional. The "all behaviors"
wording looks like it is left over from the earlier design, even after the
v6 commit message update.

The commit message also leaves out a few other changes in the patch:

- gve_alloc_control_plane_resources() now allocates the counter array
  after the notify blocks and stats report, followed by irq_db_indices.
  gve_free_control_plane_resources() changes its free order to match.

- A new gve_ntfy_to_msix_idx() helper is now used for the msix_vectors[]
  lookups in gve_setup_notify_blocks() and gve_teardown_notify_blocks().
  The "Failed to receive msix vector" message now prints msix_idx.

- The "the last vector" and "the first n-1 vectors" comments are removed,
  although mgmt_msix_idx is still num_ntfy_blks.

None of these seem to change behavior in AdminQ mode. Could the commit
message be updated to match the code and mention these changes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930190428.1130007-1-hramamurthy%40google.com
