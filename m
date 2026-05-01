Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53793DEAC0
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650900; cv=none; b=ay3bGULvm1FathE7PRCvPCNNknGsbuVpjSYcB5tyItFRzpwC099XSUHiW5pAvMaZj+K/EDWScf8Iy01Wxtpwr9nctY6n7Ip24uehLVguK9k+jbDAiXhQpMstsNyopKmCRHid9a0FldvdQ/ShppTP971kAls8ht6v9TgbtV+zVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650900; c=relaxed/simple;
	bh=bsjJkCQQ3A6wOmfjBiVNfgTsuRZsYVDWU3le/fd6dgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8PxRN1uP0jK+523ahzZzP3EeAsYM8HtNSi9eUF9K5MEjgmAqR159y6dDOj4S7fc2C8x0VZ4gWCMLku/873/aEsum8nQUJwJrZI5dNPDZU8mubehcMNDQ/0Aq1IfPFjsHOPn9xqOH8CgztQPJjr/OyjiQRWhpzneqiB3Xnn3qRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=sKonh8Us; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="sKonh8Us"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b3eab6ec9bso37459706d6.1
        for <bpf@vger.kernel.org>; Fri, 01 May 2026 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777650898; x=1778255698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC9LgXYHX18qXHOQH91JWhKa/OCKeKNcth3XKvgxSns=;
        b=sKonh8UsmSmngh/XVlT+XNAXd1rDualq82ug+L2obUIG2xktWPAerCIFGEkZESXEAx
         slMaI+uV4OQcAUe1dNU/GqifP3Tv0jDhS0oPuDgok2mVT7t7eXKpsfBBRRv3q1JAp+34
         xXkNJnjnRrplZiAGpnkFnp0af10zHaggkcx/wtZ9pNgpAuhwlc+OHaUpTD4Q2dr/TX1z
         9T8efseUMQlALWTaQ2nvkgL00oEQ+T/Xk1axptvisqWI2/6552CHLWPBSfVniHz8o2vC
         Ble4KDKZjgWyDnDitN+glVASA743tjJTa2mT8vZBOZ9JgGhDokSzco0PCccpsDqOri17
         +zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650898; x=1778255698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wC9LgXYHX18qXHOQH91JWhKa/OCKeKNcth3XKvgxSns=;
        b=EPoHBJx3dVYvKt4nDBbvy+aJTBjRKuOCnLaxtX2MeJZ87bqDSK7XdeSB5N45IoNUiP
         S0S1Sb7VNtxIAUVK+DlpCXAlKpvy7RZMbpDsK2qAmsGL079SePgjUHTnskyFoklz6+q+
         Nf4wnRUbIBltZejNBgLLzp1zYG3gXenkKSlMjPax+AKH2c+qgCl2GLx+UfZq/wAfaRF9
         HQNyblefMXkYrDaCIIgBVOpbcnswS9ql4sFSspDStIb7sqiaQCdwDPrVm8Qd5CmyYKQZ
         Jv+nO835xErpo0/Mzky9G2liy8o/E5CgecrPZE8k/CAnyNi2J4mRR0kynzacFNwa6dbi
         WL7g==
X-Forwarded-Encrypted: i=1; AFNElJ+OWnHtzV2Jlw332bS0rmiAFpi+I9ImiKFbvEFzkH26aWagnVy8irFH1VyYuabkdi1xUus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaASK0qPvlBc8yxUH1OMb2MTeqcBl17TkljjIKIONCS1Urq9WS
	JoqA+PHD7nhHfxlv17jXE6V+yEbhZxqgqf9OEbmfN2EjoMoL93rlBrsyO0VXknHGmXY=
X-Gm-Gg: AeBDiesL6HAf01v8lYUWq3IhASbqQI1s+diJ9hTsLITldlkWW/nDTcrPyI1qCPbA2J4
	ykRT4w0bZ/kpDYBzgdgz6KBPtPRktO00lmiDmwQqxyDCiHMqQrQlfPwdr8emrXGPV3CAUUT7YUM
	Ebf9wDaaaoSczoD7zc3KkhzllLY0hL8H0ZbF8jF6t9UHqIariAQkZPjf3DuRPWvFO6VdQSK2DKo
	k9WmYS/hIvx0z9+8geBoJVnuk5QYtYWEyg9edwcxlucWvWRH6wcy3f6qttlqEw6PAwsvdFs8vLi
	Dl/W/ghrOEnCaAkqDeDqQhUW3LDMKHeiOpqPCOzdpr4bxCwF7GRw9ZIjAxMmWlOiCOMkvvb2A5M
	jEGZ1VZngbNXxtJNHZX6z9bhXmyeeqkY+NClbUn/m89jDVPLwbyyW5jS0sbuivFyhMIPOcMJO3j
	IQW9hKHMg1ximgIyg4tIQNXAIqDZ4+lN9ANuJwntDkT+OEcHLSkD4Xnoi9PKdMzRqNMpqh1x+zk
	y9wTA==
X-Received: by 2002:ad4:5ba5:0:b0:8ac:adca:2325 with SMTP id 6a1803df08f44-8b40001d5b5mr105107896d6.15.1777650897594;
        Fri, 01 May 2026 08:54:57 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b539aa7293sm26615406d6.22.2026.05.01.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:54:57 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: daniel@riscstar.com,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	matthew.gerlach@altera.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/12] gpio: tc956x: add TC956x/QPS615 support
Date: Fri,  1 May 2026 10:54:17 -0500
Message-ID: <20260501155421.3329862-10-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260501155421.3329862-1-elder@riscstar.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Toshiba TC956x is an Ethernet-AVB/TSN bridge and is essentially
a small and highly-specialized SoC.  TC956x includes a GPIO block that
can be accessed, alongside several other peripherals, via two PCIe
endpoint functions.  The PCIe function driver creates an auxiliary
device for the GPIO block, and that device gets bound to this auxiliary
device driver.

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/gpio/Kconfig       |  11 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-tc956x.c | 209 +++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/gpio/gpio-tc956x.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 020e51e30317a..746cedea7e91d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1646,6 +1646,17 @@ config GPIO_TC3589X
 	  This enables support for the GPIOs found on the TC3589X
 	  I/O Expander.
 
+config GPIO_TC956X
+	tristate "Toshiba TC956X GPIO support"
+	depends on TOSHIBA_TC956X_PCI
+	default m if TOSHIBA_TC956X_PCI
+	help
+	  This enables support for the GPIO controller embedded in the Toshiba
+	  TC956X (and Qualcomm QPS615).  This device connects to the host
+	  via PCIe port, which is the upstream port on an internal PCIe
+	  switch.  On some platforms, a few of the GPIO lines are used to
+	  manage external resets.
+
 config GPIO_TIMBERDALE
 	bool "Support for timberdale GPIO IP"
 	depends on MFD_TIMBERDALE
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index b267598b517de..c3584e7cba9b4 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -178,6 +178,7 @@ obj-$(CONFIG_GPIO_SYSCON)		+= gpio-syscon.o
 obj-$(CONFIG_GPIO_TANGIER)		+= gpio-tangier.o
 obj-$(CONFIG_GPIO_TB10X)		+= gpio-tb10x.o
 obj-$(CONFIG_GPIO_TC3589X)		+= gpio-tc3589x.o
+obj-$(CONFIG_GPIO_TC956X)		+= gpio-tc956x.o
 obj-$(CONFIG_GPIO_TEGRA186)		+= gpio-tegra186.o
 obj-$(CONFIG_GPIO_TEGRA)		+= gpio-tegra.o
 obj-$(CONFIG_GPIO_THUNDERX)		+= gpio-thunderx.o
diff --git a/drivers/gpio/gpio-tc956x.c b/drivers/gpio/gpio-tc956x.c
new file mode 100644
index 0000000000000..12221d8f812d9
--- /dev/null
+++ b/drivers/gpio/gpio-tc956x.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+/*
+ * The Toshiba TC956X implements a PCIe Gen 3 switch that connects an
+ * upstream x4 port to two downstream PCIe x2 ports.  It incorporates
+ * an internal endpoint on a internal PCIe port that implements two
+ * Synopsys XGMAC Ethernet interfaces.
+ *
+ * 35 GPIOs are also implemented by an embedded GPIO controller.  Three
+ * registers control the first 32 GPIOs (other than 20 and 21, which are
+ * reserved).  Three other registers control GPIOs 32 through 36. GPIOs
+ * 22-24, 27-28, 31, and 34 are treated as "input only".
+ *
+ * There is a TC956X PCI power controller driver that accesses the
+ * direction and output value registers for GPIOs 2 and 3.  These
+ * GPIOs control the reset signal for the two downstream PCIe ports.
+ * Their values will never change during operation of this driver, and
+ * this driver reserves these two GPIOS.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/dev_printk.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define DRIVER_NAME		"tc956x-gpio"
+
+#define TC956X_GPIO_COUNT	37	/* Number of GPIOs (20-21 reserved) */
+
+/* The GPIO offsets are relative to 0x1200 in TC956X SFR space */
+#define GPIO_IN0_OFFSET		0x00		/* Input value (0-31) */
+#define GPIO_EN0_OFFSET		0x08		/* 0: out; 1: in (0-31) */
+#define GPIO_OUT0_OFFSET	0x10		/* Output value (0-31) */
+
+#define GPIO_IN1_OFFSET		0x04		/* Input value (32-36) */
+#define GPIO_EN1_OFFSET		0x0c		/* 0: out; 1: in (32-36) */
+#define GPIO_OUT1_OFFSET	0x14		/* Output value (32-36) */
+
+/*
+ * struct tc956x_gpio - Information related to the embedded GPIO controller
+ * @chip:		GPIO chip structure
+ * @regmap:		MMIO register map for SFR GPIO region access
+ * @input_only:		Bitmap indicating which GPIOs are input-only
+ */
+struct tc956x_gpio {
+	struct gpio_chip chip;
+	struct regmap *regmap;
+	DECLARE_BITMAP(input_only, TC956X_GPIO_COUNT);
+};
+
+static int tc956x_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
+	u32 reg;
+	u32 val;
+
+	if (test_bit(offset, gpio->input_only))
+		return GPIO_LINE_DIRECTION_IN;
+
+	reg = offset < 32 ? GPIO_EN0_OFFSET : GPIO_EN1_OFFSET;
+
+	regmap_read(gpio->regmap, reg, &val);
+	if (val & BIT(offset % 32))
+		return GPIO_LINE_DIRECTION_IN;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static int tc956x_gpio_direction_input(struct gpio_chip *gc,
+				       unsigned int offset)
+{
+	u32 reg = offset < 32 ? GPIO_EN0_OFFSET : GPIO_EN1_OFFSET;
+	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
+	u32 mask = BIT(offset % 32);
+
+	return regmap_update_bits(gpio->regmap, reg, mask, mask);
+}
+
+static int tc956x_gpio_direction_output(struct gpio_chip *gc,
+					unsigned int offset, int value)
+{
+	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
+	u32 vreg;
+	u32 dreg;
+	u32 mask;
+
+	if (test_bit(offset, gpio->input_only))
+		return -EINVAL;
+
+	if (offset < 32) {
+		vreg = GPIO_OUT0_OFFSET;
+		dreg = GPIO_EN0_OFFSET;
+	} else {
+		vreg = GPIO_OUT1_OFFSET;
+		dreg = GPIO_EN1_OFFSET;
+	}
+	mask = BIT(offset % 32);
+
+	/* Set output value first, then direction */
+	regmap_update_bits(gpio->regmap, vreg, mask, value ? mask : 0);
+
+	return regmap_update_bits(gpio->regmap, dreg, mask, 0);
+}
+
+static int tc956x_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	u32 reg = offset < 32 ? GPIO_IN0_OFFSET : GPIO_IN1_OFFSET;
+	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
+	u32 val;
+
+	regmap_read(gpio->regmap, reg, &val);
+
+	return val & BIT(offset % 32) ? 1 : 0;
+}
+
+static int tc956x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	u32 reg = offset < 32 ? GPIO_OUT0_OFFSET : GPIO_OUT1_OFFSET;
+	struct tc956x_gpio *gpio = gpiochip_get_data(gc);
+	u32 mask = BIT(offset % 32);
+
+	return regmap_update_bits(gpio->regmap, reg, mask, value ? mask : 0);
+}
+
+static int tc956x_gpio_init_valid_mask(struct gpio_chip *gc,
+				       unsigned long *valid_mask,
+				       unsigned int ngpios)
+{
+	/*
+	 * GPIOs 2 and 3 are used by the PCI power control driver, and
+	 * we don't allow them to be used.  GPIOs 20 and 21 are reserved
+	 * (and not usable).
+	 */
+	bitmap_fill(valid_mask, ngpios);
+	bitmap_clear(valid_mask, 2, 2);
+	bitmap_clear(valid_mask, 20, 2);
+
+	return 0;
+}
+
+static int tc956x_gpio_probe(struct auxiliary_device *adev,
+			     const struct auxiliary_device_id *id)
+{
+	struct device *dev = &adev->dev;
+	struct tc956x_gpio *gpio;
+	struct gpio_chip *gc;
+
+	if (!dev->platform_data)
+		return -EINVAL;
+
+	gpio = devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+	gpio->regmap = dev->platform_data;
+
+	/* Mark GPIOs 22, 23, 24, 27, 28, 31, and 34 as input only */
+	bitmap_set(gpio->input_only, 22, 3);
+	bitmap_set(gpio->input_only, 27, 2);
+	set_bit(31, gpio->input_only);
+	set_bit(34, gpio->input_only);
+
+	gc = &gpio->chip;
+
+	gc->label = DRIVER_NAME;
+	gc->parent = dev->parent;
+
+	gc->get_direction = tc956x_gpio_get_direction;
+	gc->direction_input = tc956x_gpio_direction_input;
+	gc->direction_output = tc956x_gpio_direction_output;
+	gc->get = tc956x_gpio_get;
+	gc->set = tc956x_gpio_set;
+	gc->init_valid_mask = tc956x_gpio_init_valid_mask;
+
+	gc->base = -1;
+	gc->ngpio = TC956X_GPIO_COUNT;
+	gc->can_sleep = false;
+
+	dev_set_drvdata(dev, gpio);
+
+	return devm_gpiochip_add_data(dev, gc, gpio);
+}
+
+static const struct auxiliary_device_id tc956x_gpio_ids[] = {
+	{ .name = "tc956x_pci.tc9564-gpio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, tc956x_gpio_ids);
+
+static struct auxiliary_driver tc956x_gpio_driver = {
+	.name		= DRIVER_NAME,
+	.probe          = tc956x_gpio_probe,
+	.id_table       = tc956x_gpio_ids,
+	.driver = {
+		.name		= DRIVER_NAME,
+		.owner		= THIS_MODULE,
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_auxiliary_driver(tc956x_gpio_driver);
+
+MODULE_DESCRIPTION("Toshiba TC956X PCIe GPIO Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("auxiliary:" DRIVER_NAME);
-- 
2.51.0

