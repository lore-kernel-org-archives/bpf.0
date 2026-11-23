Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444039;
	b=iN7ZhmEzkCYUyca0W41R16H/PUKct0ovUX0yJtE5SBF2cowBicI+zxbsaKmrLhTbu09G
	 4/YbidvQIvJKTvX1UX18DtuAug+ng0LMXFnNN3JvZEv4r/Q19aUHdvY8LIsZ7BCNxBMp/
	 N0qXLkcX4TGw163DIaOhAKei/DgJ5Bj1mjc9qik/NmvRHTj8+qz2XZo3DraZ4gHrrPKtQ
	 guqQJdV7Rbpe6PD0YnU4+JPBHUeG85XTaDt4f0MbpO5gg4VhktrI6u3cqEE5KA8X4hrLC
	 nwKO6zAIeZpBkRwLJe795jYQjYciAyvurZcAckUxGoryEFXwKAjrkDiCC3Ldi6q+2kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444039;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ROEpEZboGA+0DmWizHDH7PqObf+8q+vCxOx24LOVIhA=;
	b=t4fNinYc2R9QykQI5+6VvnoK+ra9OZfipqcSjO22yENyW8mZaHRQM22eiRevAkzzX4wq
	 TmQGem3ATA66Qr3AK9znAIZxJEMCnpDUIQvkjRh+vcUodK50OjhcQCmJFli5/WmEHjFbb
	 +vgZ1TP3yBBtatMfcX6RnsdDATWqnXojR6Yt5CbmrLrhL9/IuJuZ/LRZo1vrJRi0AmXsz
	 3VC6udVpYFD1nzXoBnjhp48kvNVk9m40BCdgjhFo96hb8c2U/WxbQbrkU+imfNJupMFhR
	 f9HLHJW22fu/QzIcbceyiD2xsYrDhImw2o+PoNuONNOE3F6b/0EbH2Xlkoo6O5ywVDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bV4WYwaq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AB606A333;
	Mon, 23 Nov 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bV4WYwaq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333491F000EB;
	Mon, 23 Nov 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795444039;
	bh=ROEpEZboGA+0DmWizHDH7PqObf+8q+vCxOx24LOVIhA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bV4WYwaq2mVrJAwB3kOlIVtuHkCpXiuw3EOn+UuUtkKzPATQjlq/+wnc4XMxq3Hcj
	 LHL4net5Lt93HGpuu7jRgaDEstYgHy/zDDHq19eFD7M/Y7/E/rv984kCV7lVB/BnNg
	 +XIgsfYaIUoJ5o7f3TYrlKoUEHGyUF4LB69PHHKoaKwcxHGMBfV8lYhsGqYSfktMXu
	 EXpPZwfiwWqPcYD+BnolkFfeSVBFhi7Zw9IABmNGijyxbf0LpomFxE23ao8KVdN8Os
	 /9D+1MX//wskqsPQsFrYlwAb1WiFxVD3OaSB9SWRXKPZgXDttR+RdJBWX1I4wdXgnk
	 nAQMnUuVHjVjw==
Subject:
 Re: [PATCH net v3 4/4] igb: only allow runtime PM if the device can wake up
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, sriram.yagnaraman@ericsson.com,
 kurt@linutronix.de, maciej.fijalkowski@intel.com, hkallweit1@gmail.com,
 joe@dama.to, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 23 Nov 2026 14:27:17 +0000
Message-ID: <179544403775.3135.15481956972342894724@kernel.org>
In-Reply-To: <20261119140412.163202-5-antonio@mandelbit.com>
References: <20261119140412.163202-5-antonio@mandelbit.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix checks wake capability only once, in igb_probe().
- [Low] Possible runtime PM usage-count imbalance in
  drivers/net/ethernet/intel/igb/igb_main.c.

--

igb: only allow runtime PM if the device can wake up

This patch changes igb_probe() so it drops the probe-time runtime PM
usage reference only when pci_dev_run_wake() reports that the device can
signal a wake-up. igb_remove() takes the reference back under the same
condition. The aim is to stop the NIC from runtime suspending into a
state where it cannot notice the link coming back.

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 4617aba5759d2..36bd395e36dab 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3654,7 +3654,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>  
> -	pm_runtime_put_noidle(&pdev->dev);
> +	/* A device that can't wake up wouldn't notice the link coming back
> +	 * while runtime suspended
> +	 */
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);

[Severity: Medium]
Is a check done only at probe time enough to keep the device out of a
D-state it can't wake from?

The PCI core recomputes both the target state and the wake enable on
every runtime suspend, after igb_runtime_suspend() has run:

pci_pm_runtime_suspend()
  pci_finish_runtime_suspend()

drivers/pci/pci.c:pci_finish_runtime_suspend() {
    ...
	target_state = pci_target_state(dev, device_can_wakeup(&dev->dev));
	if (target_state == PCI_POWER_ERROR)
		return -EIO;

	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));

	error = pci_set_power_state(dev, target_state);
    ...
}

If igb probes while d3cold_allowed is 0 or no_d3cold is set,
acpi_pci_choose_state() caps the target at D3hot:

	if (pdev->no_d3cold || !pdev->d3cold_allowed)
		d_max = ACPI_STATE_D3_HOT;

If the NIC has PME from D3hot, pci_dev_run_wake() is true there, so the
usage reference gets dropped.

Later, root can set d3cold_allowed back to 1 through sysfs, or
pci_d3cold_enable() can clear no_d3cold. The target can then become
D3cold. On a NIC whose PME_Support has no D3cold bit, pci_dev_run_wake()
is now false, and the core would put the device into D3cold with wake
disabled.

Even then, igb_runtime_idle() still schedules a suspend whenever there is
no link:

	if (!igb_has_link(adapter))
		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);

Could this bring back the behaviour the commit message describes, where
the port stays down until it is resumed from user space? Would it make
sense to also refuse runtime suspend in igb_runtime_idle() or
igb_runtime_suspend() (for example by returning -EBUSY) when
pci_dev_run_wake() is false at that point?

I have only checked the code path here. I have not confirmed that real
82576/i350 parts on D3cold-capable platforms lack PME from D3cold.

>  	return 0;
>  
>  err_register:
> @@ -3876,7 +3880,8 @@ static void igb_remove(struct pci_dev *pdev)
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  
> -	pm_runtime_get_noresume(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);

[Severity: Low]
Can this pci_dev_run_wake() call give a different answer than the one in
igb_probe()?

igb_probe() doesn't save its result. pci_dev_run_wake() recomputes it on
every call from pci_pme_capable(dev, pci_target_state(dev, true)).

Several inputs to the target state can change at runtime:

  - d3cold_allowed, which root can write through d3cold_allowed_store()
  - no_d3cold
  - PM_QOS_FLAG_NO_POWER_OFF in acpi_pm_device_sleep_state()
  - acpi_target_system_state()

On a NIC with PME from D3hot but not from D3cold, changing
d3cold_allowed between probe and unbind is enough to flip the answer.

pci_device_remove() relies on ->remove() undoing exactly what probe did:

drivers/pci/pci-driver.c:pci_device_remove() {
    ...
		pm_runtime_get_sync(dev);
		pm_runtime_barrier(dev);
		drv->remove(pci_dev);
		pm_runtime_put_noidle(dev);
    ...
	pm_runtime_put_sync(dev);
}

If probe saw false and remove sees true, one usage reference leaks. The
device can then never runtime suspend again, even after rebinding with
power/control set to auto.

If probe saw true and remove sees false, the final pm_runtime_put_sync()
drops one reference too many. With power/control set to auto, the usage
count underflows and the kernel warns. With power/control set to on, the
forbid reference is used up and the user's setting is lost.

Before this patch, the put_noidle/get_noresume pair was unconditional and
couldn't mismatch. e1000e and r8169 re-evaluate pci_dev_run_wake() in the
same way.

Would it be safer to record the decision made in igb_probe(), for example
as a flag in struct igb_adapter, and test that flag in igb_remove()?

>  #ifdef CONFIG_IGB_HWMON
>  	igb_sysfs_exit(adapter);
>  #endif

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119140412.163202-1-antonio%40mandelbit.com
