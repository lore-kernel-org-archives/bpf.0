Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465845BD4E;
	Tue, 21 Jul 2026 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645021; cv=none; b=iD49Hb03yHewhg6+/QnObidwN665pGsDBCy5xUCKw1eF/ckoZIiGJF28juPLfsvNgxN0Y8M8utyu9wxhcKbp9wSPH+wocOtgSqEsla9uuUz7epmRc5hs8bmH1ncORacHlksz09GZxOZWge1GQFB703V40sH+eJuuqTvKXTV/gtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645021; c=relaxed/simple;
	bh=YBZobvZulref+ytTGCBwwhnpwe8D9jv2O4bavxMo9xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzoTZUGvZTH7TW5F5AGhPBARyavok2L6ygKwPVaTnjsh5AUK8OdLQW/dlLS3pRqxM1LgFJ2SD0w7ZHK3pX7dRz41zlbjkgp+G1Ux5rq2Md0CkJQU5nwzbRMj3ILo05oiI6giHxr7HB0bGCOFxXyDkEq5qRjzP9Hx/rDmsGvLLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeOg9MZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeOg9MZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61801F00A3A;
	Tue, 21 Jul 2026 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784645020;
	bh=CoaJ4JQlhsur87M2sZ8MdbclmParip6HqlDhl36M69U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OeOg9MZYHYWJk+8RJHJix30NLs9DXIocVM1NhRW2AdZJLU6vA3hHVT612wLqtbX8R
	 pwkB2YKfda1RWLYiNPG/xmj2cuuaXRZAhDzS994W2WYP1tUBPS46eXvbYafY/w7bIX
	 CbKz2xTJGlr0V2lUJbG4WEtfyWnODdpjU6PKMVBSS6Uh6/MA3eH4M4unDcTSpMm+4Z
	 4URNsbhjOZNdtN1tztSY1KqM+hc3Qz0HnzI85kWU6EDt24ViMdoagUeVrYfvQB6Zvi
	 INTBpBmafSWqclWPSZMwJSHU+wQLfyIvo6YERDxfIGqV0b5aKaNNb4dvTr/PXOjgva
	 4/swDgOdawG2g==
Date: Tue, 21 Jul 2026 16:43:21 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, daniel@riscstar.com, 
	mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com, alexandre.torgue@foss.st.com, 
	ast@kernel.org, boon.khai.ng@altera.com, chenchuangyu@xiaomi.com, 
	chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org, hkallweit1@gmail.com, 
	inochiama@gmail.com, john.fastabend@gmail.com, julianbraha@gmail.com, 
	livelycarpet87@gmail.com, mcoquelin.stm32@gmail.com, me@ziyao.cc, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com, rohan.g.thomas@altera.com, 
	sdf@fomichev.me, siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com, 
	wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/14] gpio: tc956x: add TC956x/QPS615 support
Message-ID: <z6fllvxd5r7bln6t6o5cacf2k35c47mnavvkmda6l4gnjaanin@52o34je2alxw>
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-13-elder@riscstar.com>
 <dhnylud7o5dhaaq6kvbes4vkml3ppa5ev542j2lyxdijibknzg@pfcy22wz6jav>
 <df217d83-272a-4d4c-8aba-a87e4b8869fc@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df217d83-272a-4d4c-8aba-a87e4b8869fc@riscstar.com>

On Thu, Jul 16, 2026 at 11:24:15AM -0500, Alex Elder wrote:
> On 7/16/26 2:02 AM, Manivannan Sadhasivam wrote:
> > On Thu, Jun 04, 2026 at 08:00:19PM -0500, Alex Elder wrote:
> > > Toshiba TC956x is an Ethernet-AVB/TSN bridge and is essentially
> > > a small and highly-specialized SoC.  TC956x includes a GPIO block that
> > > can be accessed, alongside several other peripherals, via two PCIe
> > > endpoint functions.  The PCIe function driver creates an auxiliary
> > > device for the GPIO block, and that device gets bound to this auxiliary
> > > device driver.
> > > 
> > > This driver is implemented using the generic regmap-based GPIO driver.
> > > 
> > 
> > While the regmap over the switch BAR works for GPIO access post-enumeration,
> > there is a blocker in using these GPIOs to control the power to endpoints.
> 
> We're aware of the power control driver and its use of these GPIOs.
> 
> I think the point you're making is not about the specific way we
> are using GPIOs, but that someone could try to use this GPIO
> controller in a way that would lead to a circular dependency
> (between the controller and the PCIe device it depends on).
> 

This not a future problem, but a present one :)

> And you suggest a GPIO driver that uses I2C (and would be
> used by the pwrctrl driver as well), and I think it's a pretty
> reasonable suggestion.
> 
> > We have a design [1] where the GPIOs from the switch are used to control power
> > and PERST# signals to the EP. With this current design, during the initial PCI
> > bus scan, the switch will get enumerated, but the EP will not. Because, power to
> > the EP depends on the GPIO Aux driver that will get probed only after the switch
> > enumeration.
> 
> Yes, on the RB3gen2 platform, reset signals (PERST#) for two of
> the TC9563 PCIe switch ports (downstream 1 and downstream 2) are
> managed by the GPIO controller that resides within the TC9563
> itself.  The pwrctl driver takes special care to ensure the GPIO
> controller is functional (powered) before trying to use it.
> 
> The TC9563 *chip* gets powered when its embedded PCIe switch is
> probed--that is, when its upstream port begins its enumeration.
> (It's a little unclear to me which of the supplies are required
> for the various non-PCIe components on the chip, including I2C
> and GPIO, to be functional.)
> 

Well, the TC9563 should get powered ON when its pwrctrl driver gets probed and
the pci_pwrctrl_power_on_device() is called. There is no dependency with the
upstream port enumeration AFAIK.

> And so until the switch gets probed (and its pwrctl driver used),
> the GPIO controller can't work.  So nothing internal to the TC956x should be
> dependent on any of the GPIOs supplied by this controller.
> (Except the pwrctrl driver, which enables power before using GPIO.)
> 
> 
> Two things to note:
> - We are working with TC9564 (and there are other successors in
>   the TC956x series).
> - Downstream port 3 (which we are using) on the switch does not
>   have such a distinct controlled reset line.
> 
> > But this creates a chicken-and-egg problem with the PCI Pwrctrl design.
> > pcie-qcom driver uses the Pwrctrl framework to power on the PCI endpoints before
> > the initial PCI bus scan. It calls pci_pwrctrl_create_devices() and
> > pci_pwrctrl_power_on_devices() APIs to create the platform device for all PCI
> > devices defined in DT (that require pwrctrl support), waits for their respective
> > pwrctrl drivers to get probed and then power ON all of them.
> 
> The way I understood it was that certain parameters for the PCIe
> links needed to be set before using them, and the pwrctrl framework
> made that possible.  (I summarize what that driver does at the end
> of this message.)
> 

Yeah, it does handle both power ON and some configuration for stable operation.

>  This step is
> > required because in DT platforms, many Root Ports are not hotplug capable and
> > also BIOS doesn't assign bridge windows during boot. So all the devices has to
> > appear during the initial PCI bus scan so that the PCI core can allocate the
> > resources properly.
> 
> This part I didn't know before.  Yes, the bridge windows are
> allocated by Linux rather than by firmware.  And if this host
> bridge doesn't support hotplug, then yes, to correctly assign
> address space, all PCIe devices must be available to report
> their required memory space.
> 
> Are you saying that "setting those parameters" wouldn't be
> needed if this particular root port supported hotplug?  (I'm
> just curious; it's not relevant to the point you're making.)
>

Yeah, more or less. If the Root Port is hotplug capable, PCI core will allocate
more resources like bridge windows and bus numbers in anticipation of devices
getting attached to it after boot. But that also sometimes becomes insufficient
if a resource hungry device like GPU gets plugged in later, as the PCI core can
only guess the memory for hotplug capable Root Port.
 
> > Now the issue with this Aux driver design is that, if an EP makes use of the
> > switch GPIO for PERST# or power, like:
> > 
> > 	tc9563: pcie@0,0 {
> > 		compatible = "pci1179,0623";
> > 		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > 		...
> > 
> > 		pcie@1,0 {
> > 			compatible = "pciclass,0604";
> > 			reg = <0x20800 0x0 0x0 0x0 0x0>;
> > 			#address-cells = <3>;
> > 			#size-cells = <2>;
> > 
> > 			device_type = "pci";
> > 			ranges;
> > 			bus-range = <0x3 0xff>;
> > 
> > 			reset-gpios = <&tc9563 5 GPIO_ACTIVE_LOW>;
> > 		};
> > 	...
> > 
> > 	};
> > 
> > Then the pwrctrl driver (pci/pwrctrl/generic.c) will try to acquire the GPIO
> > controller during its probe, but will fail with -EPROBE_DEFER as the GPIO
> > controller won't be available at that time. So the whole PCIe instance will
> > probe defer as the driver requires all pwrctrl drivers to be probed before
> > starting the initial bus scan.
> 
> The only GPIOs we're using are for asserting reset on the two
> Ethernet PHYs.  That doesn't occur until after the embedded
> endpoint functions are probed, so this should be OK.
> 
> However you're right, the lines on this GPIO controller should
> be restricted to avoid this circular dependency.
> > So we need to make sure that the GPIO controller driver is available before
> > enumerating the switch device. One way to achieve is by creating the GPIO Aux
> > device in the pci/pwrctrl/pci-pwrctrl-tc9563.c driver and let the GPIO
> > controller driver use I2C communication for setting up the GPIOs. Thankfully,
> > the switch allows both I2C and BAR MMIO configurations for internal GPIOs.
> 
> Daniel and I have talked about this solution exactly, but opted
> not to propose using it just yet (not unless someone like you
> suggested it...).  Our solution for now was just to have the
> (PCIe BAR-based) GPIO driver reserve the two GPIO lines used by
> the pwrctrl driver, and rely on the fact that the pwrctrl driver
> will only touch those shared registers at times the "real" GPIO
> driver does not.
> 

Yeah. If those GPIO lines are not used to power up any endpoint devices, then
there should be no issues. But this is something we cannot control as the board
designers can do whatever they want.

> 
> We could instead implement a "proper" I2C-based GPIO controller
> driver.  This would be used by the pwrctrl driver (rather than
> that driver just updating the registers directly), as well as
> the Ethernet PHY for reset control, and for any other uses on
> future platforms.
> 

Sounds like a plan.

> All uses so far are for managing resets, so the higher I2C
> latency wouldn't be much of an issue.
> 
> > With this change, the GPIO driver will get probed by the time the pwrctrl
> > generic driver acquires the 'reset-gpios' and will turn ON the EP.
> 
> One thing I'll point out is that the next version of this
> code will define "pci-ep-bus" nodes, and will not use the
> auxiliary bus model.  However the issue you raise remains
> in that model too.
> 

Please do CC me on the upcoming versions as well.

> Thank you very much for raising this Mani.  Please see my
> questions a little further below.
> 
> 					-Alex
> 
> > Let me know your thoughts!
> > 
> > - Mani
> > 
> > [1] https://lore.kernel.org/linux-pci/e2inl7k5gsjj6oomv2k5ximuzpb3gfiz66ufet3b4hvov7zqt4@qz4pifbos7yf/
> 
> 
> Here's what the pwrctrl driver does:
> 
> In drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c, the registers at
> offset 0x1208 and 0x1210 from the base of the "SFR" address space
> are updated to assert/deassert these two reset signals.  It does
> so using the I2C interface--out of band from access via PCI BARs.
> The reset signals are GPIO02 (for downstream endpoint 1 on the
> switch) and GPIO03 (for endpoint 2), which are controlled by
> bits 2 and 3 in the two registers, respectively.
> 
> The pwrctrl driver enables a set of regulators defined in the
> devicetree node for the upstream port of the TC9564 embedded
> PCIe switch.  It then asserts the main RESX (chip) reset signal,
> and after a short delay asserts these other two resets.
> 
> At that point it uses properties defined in devicetree to
> configure five "ports":  upstream, downstream 1-3, and Ethernet.
> (I have some questions related to this--but I put them below.)
> The properties configured are:  ASPM L0s entry delay; ASP L1 entry
> delay; TX amplitude; Number of Fast Training Sequences (NTFS); and Decision
> Feedback Equalization (DFE).
> 

The driver confuses between ports and endpoint. TC9563_ETHERNET is not a port,
but an integrated endpoint. I've identified some issues while reviewing it now.
Will try to fix them asap.

> Finally, the two resets and the main RESX reset are deasserted,
> and the driver reports that the device is now ready, with:
>   devm_pci_pwrctrl_device_set_ready();
> 
> 
> 
> Questions related to the "ports" configured by the pwrctrl driver:
> - Given that downstream port 3 connects to the internal, embedded
>   PCIe endpoint, does it still require these settings programmed?
> 

Not all of the settings are applicable to all ports. Only ASPM and N_FTS are
applicable to all ports and endpoints, but the rest are optional. But the driver
treats all properties mandatory for all ports/endpoint, and safeguards itself by
having some absurd checks. This is something I'm going to fix.

> - Does the TC9563 chip have only *one* function on its embedded
>   endpoint, supporting just one Ethernet?
>     - If so, this driver will have to be modified to support
>       the second embedded function and Ethernet controller.
> 

The driver assumes only one endpoint, but the binding lists 2. So the driver is
not complying with its own binding now :/

So technically, the driver supports 2 integrated endpoints.

> - Why is "Ethernet" configured like the PCIe ports, *in addition*
>   to the downstream port 3 that it sits behind?
> 

Both ASPM and N_FTS properties are applicable to ports and integrated endpoints
as well. But other 2, DFE and Tx Amplitude are only applicable to ports only,
excluding DSP3.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
